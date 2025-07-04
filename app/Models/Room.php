<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Room extends Model
{
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'user_id',
        'room_id',
        'title',
        'subject',
        'section',
        'description',
        'profile_image',
        'cover_image',
        'code',
    ];

    /**
     * Get the user (creator) that owns the room.
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
