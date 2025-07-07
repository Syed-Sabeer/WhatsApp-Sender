<?php 
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FileMessage extends Model
{
    protected $fillable = [
        'mobile_number',
        'file_path',
        'original_filename',
        'status',
    ];
}
