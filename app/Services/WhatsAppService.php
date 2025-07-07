<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Cache;

class WhatsAppService
{
    private $nodeServerUrl;
    private $timeout;

    public function __construct()
    {
        $this->nodeServerUrl = config('whatsapp.node_server_url');
        $this->timeout = config('whatsapp.timeout');
    }

    /**
     * Get WhatsApp connection status
     */
    public function getStatus()
    {
        try {
            $response = Http::timeout($this->timeout)->get($this->nodeServerUrl . '/status');

            if ($response->ok()) {
                $data = $response->json();
                Cache::put('whatsapp_status', $data, 5);
                return $data;
            }

            return $this->getDefaultStatus('Unable to reach Node server');
        } catch (\Exception $e) {
            Log::error('WhatsApp status check failed', ['error' => $e->getMessage()]);
            return $this->getDefaultStatus('Connection error: ' . $e->getMessage());
        }
    }

    /**
     * Send a file to WhatsApp
     */
    public function sendFile($number, $fileUrl, $originalFilename = null)
    {
        try {
            $response = Http::timeout($this->timeout)->post($this->nodeServerUrl . '/send', [
                'number' => $number,
                'file_url' => $fileUrl,
                'original_filename' => $originalFilename,
            ]);

            if ($response->ok()) {
                Log::info('WhatsApp file sent successfully', [
                    'number' => $number,
                    'file_url' => $fileUrl
                ]);
                return ['success' => true, 'message' => 'File sent successfully'];
            }

            Log::error('WhatsApp send failed', [
                'number' => $number,
                'file_url' => $fileUrl,
                'response' => $response->body(),
                'status' => $response->status()
            ]);

            return ['success' => false, 'message' => 'Failed to send file'];
        } catch (\Exception $e) {
            Log::error('WhatsApp send exception', [
                'number' => $number,
                'file_url' => $fileUrl,
                'error' => $e->getMessage()
            ]);

            return ['success' => false, 'message' => 'Connection error'];
        }
    }

    /**
     * Force quit all tasks
     */
    public function forceQuit()
    {
        try {
            $response = Http::timeout($this->timeout)->post($this->nodeServerUrl . '/force-quit');

            if ($response->ok()) {
                Log::info('WhatsApp force quit requested');
                return ['success' => true, 'message' => 'Force quit requested'];
            }

            return ['success' => false, 'message' => 'Failed to force quit'];
        } catch (\Exception $e) {
            Log::error('Force quit failed', ['error' => $e->getMessage()]);
            return ['success' => false, 'message' => 'Connection error'];
        }
    }

    /**
     * Reconnect WhatsApp client
     */
    public function reconnect()
    {
        try {
            $response = Http::timeout($this->timeout)->post($this->nodeServerUrl . '/reconnect');

            if ($response->ok()) {
                Log::info('WhatsApp reconnection initiated');
                return ['success' => true, 'message' => 'Reconnection initiated'];
            }

            return ['success' => false, 'message' => 'Failed to reconnect'];
        } catch (\Exception $e) {
            Log::error('Reconnect failed', ['error' => $e->getMessage()]);
            return ['success' => false, 'message' => 'Connection error'];
        }
    }

    /**
     * Check if WhatsApp is connected
     */
    public function isConnected()
    {
        $status = $this->getStatus();
        return $status['connected'] ?? false;
    }

    /**
     * Check if tasks are running
     */
    public function isTaskRunning()
    {
        $status = $this->getStatus();
        return $status['taskRunning'] ?? false;
    }

    /**
     * Get task status
     */
    public function getTaskStatus()
    {
        try {
            $response = Http::timeout($this->timeout)->get($this->nodeServerUrl . '/task-status');
            
            if ($response->ok()) {
                $data = $response->json();
                return [
                    'taskRunning' => $data['taskRunning'] ?? false,
                    'currentTask' => $data['currentTask'] ?? null,
                    'queueLength' => $data['queueLength'] ?? 0,
                    'totalFiles' => $data['totalFiles'] ?? 0,
                    'sentFiles' => $data['sentFiles'] ?? 0,
                    'failedFiles' => $data['failedFiles'] ?? 0,
                    'progress' => $data['progress'] ?? 0,
                    'logs' => $data['logs'] ?? []
                ];
            }
            
            return [
                'taskRunning' => false, 
                'queueLength' => 0, 
                'totalFiles' => 0,
                'sentFiles' => 0,
                'failedFiles' => 0,
                'progress' => 0,
                'logs' => []
            ];
        } catch (\Exception $e) {
            return [
                'taskRunning' => false, 
                'queueLength' => 0, 
                'totalFiles' => 0,
                'sentFiles' => 0,
                'failedFiles' => 0,
                'progress' => 0,
                'logs' => []
            ];
        }
    }

    /**
     * Get default status response
     */
    private function getDefaultStatus($errorMessage)
    {
        return [
            'connected' => false,
            'initializing' => false,
            'qr' => null,
            'logs' => ['❌ ' . $errorMessage],
            'taskRunning' => false,
            'currentTask' => null,
            'queueLength' => 0,
            'reconnectAttempts' => 0
        ];
    }
} 