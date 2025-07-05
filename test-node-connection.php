<?php

echo "🔍 Testing Node.js server connection...\n\n";

// Test the lightweight server endpoints
$endpoints = [
    '/',
    '/health',
    '/status'
];

foreach ($endpoints as $endpoint) {
    $url = 'https://whatsapp.deveondynamics.com' . $endpoint;
    echo "Testing: {$url}\n";
    
    try {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 10);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $error = curl_error($ch);
        curl_close($ch);
        
        if ($error) {
            echo "❌ Error: {$error}\n";
        } elseif ($httpCode == 200) {
            echo "✅ SUCCESS! HTTP {$httpCode}\n";
            $data = json_decode($response, true);
            if ($data) {
                echo "Response: " . json_encode($data, JSON_PRETTY_PRINT) . "\n";
            } else {
                echo "Response: {$response}\n";
            }
        } else {
            echo "❌ HTTP {$httpCode}\n";
            echo "Response: {$response}\n";
        }
    } catch (Exception $e) {
        echo "❌ Exception: " . $e->getMessage() . "\n";
    }
    
    echo "---\n";
}

echo "\n🎉 If you see successful responses above, your server is working!\n";
echo "Update your Laravel .env file with:\n";
echo "WHATSAPP_NODE_SERVER_URL=https://whatsapp.deveondynamics.com\n"; 