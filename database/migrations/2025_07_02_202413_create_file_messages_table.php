<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
public function up()
{
    Schema::create('file_messages', function (Blueprint $table) {
        $table->id();
        $table->string('mobile_number');
        $table->string('file_path');
        $table->enum('status', ['pending', 'sent', 'failed'])->default('pending');
        $table->timestamps();
    });
}


    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('file_messages');
    }
};
