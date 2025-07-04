<?php

/**
 * Database and Model Test Script
 * 
 * This script tests the database connection and FileMessage model functionality.
 */

require_once 'vendor/autoload.php';

// Bootstrap Laravel
$app = require_once 'bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\FileMessage;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

echo "🔍 Testing Database and FileMessage Model\n";
echo "=========================================\n\n";

try {
    // Test 1: Database Connection
    echo "1. Testing Database Connection...\n";
    DB::connection()->getPdo();
    echo "   ✅ Database connection successful\n";
    
    // Test 2: Check if file_messages table exists
    echo "\n2. Testing file_messages table...\n";
    $tableExists = DB::getSchemaBuilder()->hasTable('file_messages');
    if ($tableExists) {
        echo "   ✅ file_messages table exists\n";
        
        // Get table structure
        $columns = DB::select("DESCRIBE file_messages");
        echo "   📋 Table structure:\n";
        foreach ($columns as $column) {
            echo "      - {$column->Field}: {$column->Type}\n";
        }
    } else {
        echo "   ❌ file_messages table does not exist\n";
        echo "   💡 Run 'php artisan migrate' to create the table\n";
    }
    
    // Test 3: Test FileMessage model
    echo "\n3. Testing FileMessage Model...\n";
    try {
        $count = FileMessage::count();
        echo "   ✅ FileMessage model works - Total records: {$count}\n";
        
        // Test creating a record
        $testMessage = FileMessage::create([
            'mobile_number' => '1234567890',
            'file_path' => 'test/test_file.pdf',
            'status' => 'pending'
        ]);
        echo "   ✅ Successfully created test record (ID: {$testMessage->id})\n";
        
        // Test updating a record
        $testMessage->status = 'sent';
        $testMessage->save();
        echo "   ✅ Successfully updated test record\n";
        
        // Test deleting the test record
        $testMessage->delete();
        echo "   ✅ Successfully deleted test record\n";
        
    } catch (Exception $e) {
        echo "   ❌ FileMessage model error: " . $e->getMessage() . "\n";
    }
    
    // Test 4: Test queries
    echo "\n4. Testing FileMessage Queries...\n";
    try {
        $pendingCount = FileMessage::where('status', 'pending')->count();
        $sentCount = FileMessage::where('status', 'sent')->count();
        $failedCount = FileMessage::where('status', 'failed')->count();
        
        echo "   📊 File Status Counts:\n";
        echo "      - Pending: {$pendingCount}\n";
        echo "      - Sent: {$sentCount}\n";
        echo "      - Failed: {$failedCount}\n";
        
        // Test grouping
        $grouped = FileMessage::all()->groupBy('mobile_number');
        echo "   📱 Files grouped by number: " . $grouped->count() . " unique numbers\n";
        
    } catch (Exception $e) {
        echo "   ❌ Query error: " . $e->getMessage() . "\n";
    }
    
    // Test 5: Test controller methods
    echo "\n5. Testing Controller Methods...\n";
    try {
        $controller = new \App\Http\Controllers\Admin\FileMessageController(
            new \App\Services\WhatsAppService()
        );
        
        // Test getFileStatus method
        $response = $controller->getFileStatus();
        $data = json_decode($response->getContent(), true);
        
        if ($data && isset($data['stats'])) {
            echo "   ✅ getFileStatus method works\n";
            echo "      - Total: {$data['stats']['total']}\n";
            echo "      - Pending: {$data['stats']['pending']}\n";
            echo "      - Sent: {$data['stats']['sent']}\n";
            echo "      - Failed: {$data['stats']['failed']}\n";
        } else {
            echo "   ❌ getFileStatus method failed\n";
        }
        
    } catch (Exception $e) {
        echo "   ❌ Controller test error: " . $e->getMessage() . "\n";
    }
    
} catch (Exception $e) {
    echo "❌ Database connection failed: " . $e->getMessage() . "\n";
}

echo "\n✅ Database and Model tests completed!\n";
echo "\n💡 If you see any errors, check:\n";
echo "   - Database configuration in .env file\n";
echo "   - Run 'php artisan migrate' to create tables\n";
echo "   - Check database permissions\n"; 