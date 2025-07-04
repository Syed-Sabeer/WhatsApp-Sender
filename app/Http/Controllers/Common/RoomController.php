<?php

namespace App\Http\Controllers\Common;

use App\Http\Controllers\Controller;
use App\Models\Room;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class RoomController extends Controller
{
public function show()
{
    if (Auth::check()) {
        $user = Auth::user();
        $currentUser = User::find($user->id);
        
        if ($currentUser->hasRole('admin') || $currentUser->hasRole('instructor') || $currentUser->hasRole('student')) {
            // Get all rooms created by current user
            $rooms = Room::where('user_id', $currentUser->id)
                        ->orderBy('created_at', 'desc')
                        ->get();
            
            return view('common.rooms', compact('rooms'));
        } else {
            return redirect()->route('frontend.home');
        }
    } else {
        return view('auth.register');
    }
}

public function detail(){
    return view('common.room_detail');
}

public function createRoom(Request $request)
    {
        // Validate request
        $request->validate([
            'title' => 'required|string|max:255',
            'subject' => 'nullable|string|max:255',
            'section' => 'nullable|string|max:255',
            'description' => 'nullable|string',
            'profile_image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
            'cover_image' => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
        ]);

        try {
            DB::beginTransaction();

            // Generate unique room_id (9 digits)
            do {
                $room_id = mt_rand(100000000, 999999999);
            } while (Room::where('room_id', $room_id)->exists());

            // Generate unique 7 character code
            do {
                $code = Str::random(7);
            } while (Room::where('code', $code)->exists());

            // Handle file uploads
            $profile_image_path = null;
            $cover_image_path = null;

            if ($request->hasFile('profile_image')) {
                $profile_image_path = $request->file('profile_image')->store('room_profiles', 'public');
            }
            
            if ($request->hasFile('cover_image')) {
                $cover_image_path = $request->file('cover_image')->store('room_covers', 'public');
            }

            // Create room
            $room = Room::create([
                'user_id' => Auth::id(),
                'room_id' => $room_id,
                'title' => $request->title,
                'subject' => $request->subject,
                'section' => $request->section,
                'description' => $request->description,
                'profile_image' => $profile_image_path,
                'cover_image' => $cover_image_path,
                'code' => $code,
            ]);

            DB::commit();

            return redirect()->route('room.list')->with('success', 'Room created successfully! Room Code: ' . $code);

        } catch (\Exception $e) {
            DB::rollback();
            
            // Delete uploaded files if they exist
            if (isset($profile_image_path)) {
                Storage::disk('public')->delete($profile_image_path);
            }
            if (isset($cover_image_path)) {
                Storage::disk('public')->delete($cover_image_path);
            }

            return redirect()->back()
                ->withInput()
                ->with('error', 'Failed to create room. Please try again.');
        }
    }

}
