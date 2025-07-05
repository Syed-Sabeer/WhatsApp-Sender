<?php

echo "🔍 Testing Node.js server connection...\n\n";

// Possible URLs to test
$possibleUrls = [
    'https://whatsapp.deveondynamics.com',
    'https://whatsapp.deveondynamics.com:3000',
    'https://whatsapp.deveondynamics.com:8080',
    'https://whatsapp.deveondynamics.com:5000',
    'https://whatsapp.deveondynamics.com:4000',
    'http://whatsapp.deveondynamics.com',
    'http://whatsapp.deveondynamics.com:3000',
    'http://whatsapp.deveondynamics.com:8080',
    'http://whatsapp.deveondynamics.com:5000',
    'http://whatsapp.deveondynamics.com:4000',
];

foreach ($possibleUrls as $url) {
    echo "Testing: {$url}/health\n";
    
    try {
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url . '/health');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 5);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $error = curl_error($ch);
        curl_close($ch);
        
        if ($error) {
            echo "❌ Error: {$error}\n";
        } elseif ($httpCode == 200) {
            echo "✅ SUCCESS! HTTP {$httpCode}\n";
            echo "Response: {$response}\n";
            echo "\n🎉 Found working URL: {$url}\n";
            echo "Update your .env file with:\n";
            echo "WHATSAPP_NODE_SERVER_URL={$url}\n\n";
            break;
        } else {
            echo "❌ HTTP {$httpCode}\n";
        }
    } catch (Exception $e) {
        echo "❌ Exception: " . $e->getMessage() . "\n";
    }
    
    echo "---\n";
}

echo "\n🔍 Testing status endpoint...\n";
$workingUrl = 'https://whatsapp.deveondynamics.com'; // Update this with the working URL from above

try {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $workingUrl . '/status');
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $error = curl_error($ch);
    curl_close($ch);
    
    if ($error) {
        echo "❌ Status endpoint error: {$error}\n";
    } elseif ($httpCode == 200) {
        echo "✅ Status endpoint working!\n";
        $data = json_decode($response, true);
        echo "Connected: " . ($data['connected'] ? 'Yes' : 'No') . "\n";
        echo "Initializing: " . ($data['initializing'] ? 'Yes' : 'No') . "\n";
        echo "Task Running: " . ($data['taskRunning'] ? 'Yes' : 'No') . "\n";
    } else {
        echo "❌ Status endpoint HTTP {$httpCode}\n";
    }
} catch (Exception $e) {
    echo "❌ Status endpoint exception: " . $e->getMessage() . "\n";
} 