<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\FileMessage;
use App\Jobs\SendWhatsAppMessage;
use App\Services\WhatsAppService;
use Illuminate\Support\Facades\Storage;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class FileMessageController extends Controller
{
    private $whatsappService;

    public function __construct(WhatsAppService $whatsappService)
    {
        $this->whatsappService = $whatsappService;
    }
  
public function upload(Request $request)
{
    $request->validate([
        'files.*' => 'required|file|max:10240',
    ]);

    $groupedMessages = [];

    foreach ($request->file('files') as $file) {
        $number = preg_replace('/[^0-9]/', '', pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME));
        $path = $file->store('uploads', 'public');

        $message = FileMessage::create([
            'mobile_number' => $number,
            'file_path' => $path,
            'status' => 'pending'
        ]);

        $groupedMessages[$number][] = $message;
    }

    // Dispatch a job once per number with all their files
    foreach ($groupedMessages as $number => $messages) {
        SendWhatsAppMessage::dispatch($number, $messages);
    }

    return redirect()->back()->with('success', 'Files uploaded and grouped WhatsApp messages dispatched.');
}

public function whatsappStatus()
{
        return response()->json($this->whatsappService->getStatus());
    }

    public function forceQuit()
    {
        $result = $this->whatsappService->forceQuit();
        return response()->json($result);
}

    public function reconnect()
    {
        $result = $this->whatsappService->reconnect();
        return response()->json($result);
    }

 public function sendAll()
{
    $messages = FileMessage::where('status', 'pending')->get();

    foreach ($messages as $message) {
            $fileUrl = config('app.url') . '/storage/' . $message->file_path;
            $result = $this->whatsappService->sendFile($message->mobile_number, $fileUrl);

            if ($result['success']) {
            $message->status = 'sent';
        } else {
            $message->status = 'failed';
            Log::error('WhatsApp Send Failed', [
                'number' => $message->mobile_number,
                    'file_url' => $fileUrl,
                    'error' => $result['message']
            ]);
        }

        $message->save();
    }

    return back()->with('success', 'All messages processed.');
}

    public function getTaskStatus()
    {
        return response()->json($this->whatsappService->getTaskStatus());
    }

    public function getFileStatus()
    {
        $files = FileMessage::orderBy('created_at', 'desc')->get();
        
        $stats = [
            'total' => $files->count(),
            'pending' => $files->where('status', 'pending')->count(),
            'sent' => $files->where('status', 'sent')->count(),
            'failed' => $files->where('status', 'failed')->count(),
        ];

        return response()->json([
            'files' => $files,
            'stats' => $stats
        ]);
    }

    public function sendPendingFiles()
    {
        try {
            Log::info('sendPendingFiles method called');
            
            $pendingFiles = FileMessage::where('status', 'pending')->get();
            Log::info('Found pending files', ['count' => $pendingFiles->count()]);
            
            if ($pendingFiles->isEmpty()) {
                Log::info('No pending files found');
                return response()->json([
                    'success' => false,
                    'message' => 'No pending files to send'
                ]);
            }

            // Group files by phone number
            $groupedFiles = $pendingFiles->groupBy('mobile_number');
            Log::info('Grouped files by number', ['groups' => $groupedFiles->keys()->toArray()]);
            
            foreach ($groupedFiles as $number => $files) {
                Log::info('Dispatching job for number', ['number' => $number, 'file_count' => $files->count()]);
                SendWhatsAppMessage::dispatch($number, $files);
            }

            Log::info('Pending files queued for sending', [
                'count' => $pendingFiles->count(),
                'numbers' => $groupedFiles->keys()->toArray()
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Pending files queued for sending',
                'count' => $pendingFiles->count()
            ]);
        } catch (\Exception $e) {
            Log::error('Error sending pending files', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Error sending pending files: ' . $e->getMessage()
            ], 500);
        }
    }

    public function retryFailedFiles()
    {
        try {
            $failedFiles = FileMessage::where('status', 'failed')->get();
            
            if ($failedFiles->isEmpty()) {
                return response()->json([
                    'success' => false,
                    'message' => 'No failed files to retry'
                ]);
            }

            // Reset status to pending
            $failedFiles->each(function ($file) {
                $file->status = 'pending';
                $file->save();
            });

            // Group files by phone number and dispatch jobs
            $groupedFiles = $failedFiles->groupBy('mobile_number');
            
            foreach ($groupedFiles as $number => $files) {
                SendWhatsAppMessage::dispatch($number, $files);
            }

            Log::info('Failed files queued for retry', [
                'count' => $failedFiles->count(),
                'numbers' => $groupedFiles->keys()->toArray()
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Failed files queued for retry',
                'count' => $failedFiles->count()
            ]);
        } catch (\Exception $e) {
            Log::error('Error retrying failed files', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Error retrying failed files: ' . $e->getMessage()
            ], 500);
        }
    }

    public function clearCompletedFiles()
    {
        try {
            $completedFiles = FileMessage::whereIn('status', ['sent', 'failed'])->get();
            $deletedCount = $completedFiles->count();
            
            if ($deletedCount === 0) {
                return response()->json([
                    'success' => false,
                    'message' => 'No completed files to clear'
                ]);
            }

            // Delete the files
            FileMessage::whereIn('status', ['sent', 'failed'])->delete();

            Log::info('Completed files cleared', [
                'count' => $deletedCount
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Completed files cleared',
                'count' => $deletedCount
            ]);
        } catch (\Exception $e) {
            Log::error('Error clearing completed files', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);

            return response()->json([
                'success' => false,
                'message' => 'Error clearing completed files: ' . $e->getMessage()
            ], 500);
        }
    }
}
