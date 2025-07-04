<?php 

namespace App\Jobs;

use App\Models\FileMessage;
use Illuminate\Bus\Queueable;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Queue\InteractsWithQueue;

class SendWhatsAppMessage implements ShouldQueue
{
    use Dispatchable, Queueable, SerializesModels, InteractsWithQueue;

    protected $number;
    protected $messages;
    public $tries = 3;
    public $timeout = 300;

    public function __construct($number, $messages)
    {
        $this->number = $number;
        $this->messages = $messages;
    }

    public function handle()
    {
        $whatsappService = app(\App\Services\WhatsAppService::class);
        
        foreach ($this->messages as $message) {
            $fileUrl = config('app.url') . '/storage/' . $message->file_path;

            try {
                // Check if WhatsApp is connected before sending
                if (!$whatsappService->isConnected()) {
                    Log::warning('WhatsApp not connected, skipping message', [
                        'number' => $this->number,
                        'file_url' => $fileUrl
                    ]);
                    $message->status = 'failed';
                    $message->save();
                    continue;
                }

                $result = $whatsappService->sendFile($this->number, $fileUrl);

                if ($result['success']) {
                    $message->status = 'sent';
                    Log::info('WhatsApp message sent successfully', [
                        'number' => $this->number,
                        'file_url' => $fileUrl
                    ]);
                } else {
                    $message->status = 'failed';
                    Log::error('WhatsApp Send Failed', [
                        'number' => $this->number,
                        'file_url' => $fileUrl,
                        'error' => $result['message']
                    ]);
                }
            } catch (\Exception $e) {
                $message->status = 'failed';
                Log::error('WhatsApp Send Exception', [
                    'number' => $this->number,
                    'file_url' => $fileUrl,
                    'error' => $e->getMessage(),
                    'attempt' => $this->attempts()
                ]);

                // If this is the last attempt, don't retry
                if ($this->attempts() >= $this->tries) {
                    Log::error('Max retry attempts reached for WhatsApp message', [
                        'number' => $this->number,
                        'file_url' => $fileUrl
                    ]);
                } else {
                    // Retry this job
                    $this->release(30); // Wait 30 seconds before retry
                    return;
                }
            }

            $message->save();
            
            // Add a small delay between files to avoid rate limiting
            sleep(1);
        }
    }

    public function failed(\Throwable $exception)
    {
        Log::error('WhatsApp message job failed', [
            'number' => $this->number,
            'error' => $exception->getMessage(),
            'trace' => $exception->getTraceAsString()
        ]);

        // Mark all messages as failed
        foreach ($this->messages as $message) {
            $message->status = 'failed';
            $message->save();
        }
    }
}
