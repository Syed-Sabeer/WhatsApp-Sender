<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Validator;

class LoginController extends Controller
{
   public function login()
    {
       if (Auth::check()) {
            $user = Auth::user();
            $currentUser = User::find($user->id);
            // Check if the user has role 'super-admin' or 'admin'
              if ($currentUser->hasRole('admin')) {
                    return redirect()->route('admin.dashboard')->with('success', "Login successfully!");
                }
                else if($currentUser->hasRole('instructor'))
                {
                    return redirect()->route('instructor.dashboard')->with('success', "Login successfully!");
                }
                else if($currentUser->hasRole('student'))
                {
                    return redirect()->route('admin.dashboard')->with('success', "Login successfully!");
                }
                 else {
                    return redirect()->route('frontend.home')->with('success', "Login successfully!");
                }
            
        } else {
            return view('auth.login');
        }
    }  

public function loginAttempt(Request $request)
    {
        // Validate the form
        $rules = [
            'email_username' => 'required|max:50',
            'password' => 'required',
        ];

        // If captcha is used
        // if (config('captcha.version') !== 'no_captcha') {
        //     $rules['g-recaptcha-response'] = 'required|captcha';
        // } else {
        //     $rules['g-recaptcha-response'] = 'nullable';
        // }

        $validate = Validator::make($request->all(), $rules);
        if ($validate->fails()) {
            return Redirect::back()->withErrors($validate)->withInput($request->all())->with('error', 'Validation Error!');
        }

        try {
            // Determine whether the input is an email or username
            $userfind = null;
            if (filter_var($request->email_username, FILTER_VALIDATE_EMAIL)) {
                // If it's an email, search by email
                $userfind = User::where('email', $request->email_username)->first();
            } else {
                // If it's not an email, assume it's a username and search by username
                $userfind = User::where('username', $request->email_username)->first();
            }

            if ($userfind) {
                // Check if the password is correct
                if (Hash::check($request->password, $userfind->password)) {
                    // Password matched
                    $remember_me = $request->remember ? true : false;
                    Auth::attempt(['email' => $userfind->email, 'password' => $request->password], $remember_me);

                    if (Auth::check()) {
                        // Role-based redirection after successful authentication
                        if ($userfind->hasRole('admin')) {
                            return redirect()->route('admin.dashboard')->with('success', "Login successfully!");
                        }
                        else if($userfind->hasRole('instructor'))
                        {
                            return redirect()->route('instructor.dashboard')->with('success', "Login successfully!");
                        }
                        else if($userfind->hasRole('student'))
                        {
                            return redirect()->route('student.dashboard')->with('success', "Login successfully!");
                        }
                        else {
                            return redirect()->route('frontend.home')->with('success', "Login successfully!");
                        }
                    } else {
                        return redirect()->back()->withInput($request->all())->with('error', 'Authentication Error');
                    }
                } else {
                    return redirect()->back()->withInput($request->all())->with('error', 'Password is mismatch');
                }
            } else {
                return redirect()->back()->withInput($request->all())->with('error', "Invalid credentials");
            }
        } catch (\Throwable $th) {
            Log::error("Failed to Login:" . $th->getMessage());
            return redirect()->back()->withInput($request->all())->with('error', "Something went wrong! Please try again later");
        }
    }

}
