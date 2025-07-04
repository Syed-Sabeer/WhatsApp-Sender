<?php

use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Auth\RegisterController;
use App\Http\Controllers\Common\DashboardController;
use App\Http\Controllers\Common\RoomController;
use App\Http\Controllers\Admin\FileMessageController;
// use App\Http\Controllers\ProfileController;
// use App\Http\Controllers\NotificationController;
// use App\Http\Controllers\UserController;
// use App\Http\Controllers\ArchivedUserController;
// use App\Http\Controllers\PermissionController;
// use App\Http\Controllers\RoleController;
// use App\Http\Controllers\SettingController;
// use App\Http\Controllers\CarBrandController;
// use App\Http\Controllers\CarModelController;
// use App\Http\Controllers\BodyTypeController;
// use App\Http\Controllers\FuelTypeController;
// use App\Http\Controllers\FeatureController;
// use App\Http\Controllers\DashboardCarListingController;
// use App\Http\Controllers\ArchivedCarListingController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('auth.Login');
});

Route::group(['middleware' => ['guest']], function () {

    //User Login Authentication Routes
    Route::get('login', [LoginController::class, 'login'])->name('login');
    Route::post('login-attempt', [LoginController::class, 'loginAttempt'])->name('login.attempt');

    //User Register Authentication Routes
    Route::get('register', [RegisterController::class, 'register'])->name('register');
    Route::post('registration-attempt', [RegisterController::class, 'registerAttempt'])->name('register.attempt');

    // Google Authentication Routes
    // Route::get('auth/google', [GoogleController::class, 'redirectToGoogle'])->name('auth.google.login');
    // Route::get('auth/google/callback', [GoogleController::class, 'handleGoogleCallback'])->name('auth.google.login.callback');
    // // Github Authentication Routes
    // Route::get('auth/github', [GithubController::class, 'redirectToGithub'])->name('auth.github.login');
    // Route::get('auth/github/callback', [GithubController::class, 'handleGithubCallback'])->name('auth.github.login.callback');
    // Facebook Authentication Routes
    // Route::controller(FacebookController::class)->group(function () {
    //     Route::get('auth/facebook', 'redirectToFacebook')->name('auth.facebook');
    //     Route::get('auth/facebook/callback', 'handleFacebookCallback');
    // });

});

Route::group(['middleware' => ['auth']], function () {
    Route::get('login-verification', [AuthController::class, 'login_verification'])->name('login.verification');
    Route::post('logout', [AuthController::class, 'logout'])->name('logout');
    Route::post('verify-account', [AuthController::class, 'verify_account'])->name('verify.account');
    Route::post('resend-code', [AuthController::class, 'resend_code'])->name('resend.code');

    // Verified notification
    Route::get('email/verify/{id}/{hash}', [AuthController::class, 'verification_verify'])->middleware(['signed'])->name('verification.verify');
    Route::get('email/verify', [AuthController::class, 'verification_notice'])->name('verification.notice');
    Route::post('email/verification-notification', [AuthController::class, 'verification_send'])->middleware(['throttle:2,1'])->name('verification.send');
    // Verified notification
});


Route::middleware(['auth'])->group(function () {
    Route::get('/deactivated', function () {
        return view('errors.deactivated');
    })->name('deactivated');
    // Route::middleware(['check.activation'])->group(function () {

        // Route::resource('profile', ProfileController::class);
        // Route::post('profile/setting/account/{id}', [ProfileController::class, 'accountDeactivation'])->name('account.deactivate');
        // Route::post('profile/security/password/{id}', [ProfileController::class, 'passwordUpdate'])->name('update.password');

        // Route::get('/notifications', [NotificationController::class, 'index']);
        // Route::post('/notifications/{id}/mark-as-read', [NotificationController::class, 'markAsRead']);
        // Route::post('/notifications/mark-all-as-read', [NotificationController::class, 'markAllAsRead']);
        // Route::post('/notifications/{id}/delete', [NotificationController::class, 'deleteNotification']);
        // Route::get('/notifications/send-test-noti/{id}', [NotificationController::class, 'testNotification']);

        Route::get('/home', [DashboardController::class, 'dashboard'])->name('dashboard');
        Route::get('/room', [RoomController::class, 'show'])->name('room.list');
        Route::get('/room/{roomId}', [RoomController::class, 'detail'])->name('room.detail');

        Route::post('/room/create', [RoomController::class, 'createRoom'])->name('room.create');

// WhatsApp File Sender Routes
Route::post('/upload-files', [FileMessageController::class, 'upload'])->name('files.upload');
Route::get('/send-whatsapp-files', [FileMessageController::class, 'sendAll'])->name('files.send');
Route::get('/whatsapp/status', [FileMessageController::class, 'whatsappStatus']);
Route::post('/whatsapp/force-quit', [FileMessageController::class, 'forceQuit'])->name('whatsapp.force-quit');
Route::post('/whatsapp/reconnect', [FileMessageController::class, 'reconnect'])->name('whatsapp.reconnect');
Route::get('/whatsapp/task-status', [FileMessageController::class, 'getTaskStatus'])->name('whatsapp.task-status');
Route::get('/files/status', [FileMessageController::class, 'getFileStatus'])->name('files.status');
Route::post('/files/send-pending', [FileMessageController::class, 'sendPendingFiles'])->name('files.send-pending');
Route::post('/files/retry-failed', [FileMessageController::class, 'retryFailedFiles'])->name('files.retry-failed');
Route::post('/files/clear-completed', [FileMessageController::class, 'clearCompletedFiles'])->name('files.clear-completed');

// Test route for debugging
Route::get('/test-file-status', [FileMessageController::class, 'getFileStatus'])->name('test.files.status');


        
        // Admin Dashboard Route
        Route::get('/admin/dashboard', function () {
            return view('admin.dashboard');
        })->name('admin.dashboard');
        
        // Instructor Dashboard Route
        Route::get('/instructor/dashboard', function () {
            return view('instructor.dashboard');
        })->name('instructor.dashboard');
        
        // Frontend Home Route
        Route::get('/frontend/home', function () {
            return view('welcome');
        })->name('frontend.home');


        // Admin Dashboard Authentication Routes (commented out due to missing controllers)
        /*
        Route::prefix('admin/dashboard')->name('dashboard.')->group(function () {

            Route::resource('user', UserController::class);
            Route::resource('archived-user', ArchivedUserController::class);
            Route::get('user/restore/{id}', [ArchivedUserController::class, 'restoreUser'])->name('archived-user.restore');
            Route::get('user/status/{id}', [UserController::class, 'updateStatus'])->name('user.status.update');

            // Role & Permission Start
            Route::resource('permissions', PermissionController::class);

            Route::resource('roles', RoleController::class);
            //Role & Permission End

            // Setting Routes
            Route::resource('setting', SettingController::class);
            Route::put('company/setting/{id}', [SettingController::class, 'updateCompanySettings'])->name('setting.company.update');
            Route::put('recaptcha/setting/{id}', [SettingController::class, 'updateRecaptchaSettings'])->name('setting.recaptcha.update');
            Route::put('system/setting/{id}', [SettingController::class, 'updateSystemSettings'])->name('setting.system.update');
            Route::put('email/setting/{id}', [SettingController::class, 'updateEmailSettings'])->name('setting.email.update');
            Route::post('send-mail/setting', [SettingController::class, 'sendTestMail'])->name('setting.send_test_mail');

            // User Dashboard Authentication Routes

            // Car Brands
            Route::resource('car-brands', CarBrandController::class);
            Route::get('car-brands/status/{id}', [CarBrandController::class, 'updateStatus'])->name('car-brands.status.update');

            // Car Models
            Route::get('car-models/{id}', [CarModelController::class, 'index'])->name('car-models.index');
            Route::get('car-models/{id}/create', [CarModelController::class, 'create'])->name('car-models.create');
            Route::post('car-models/{id}/store', [CarModelController::class, 'store'])->name('car-models.store');
            Route::get('car-models/edit/{id}', [CarModelController::class, 'edit'])->name('car-models.edit');
            Route::put('car-models/update/{id}', [CarModelController::class, 'update'])->name('car-models.update');
            Route::delete('car-models/destroy/{id}', [CarModelController::class, 'destroy'])->name('car-models.destroy');
            Route::get('car-models/status/{id}', [CarModelController::class, 'updateStatus'])->name('car-models.status.update');

            // Body Types
            Route::resource('body-types', BodyTypeController::class);
            Route::get('body-types/status/{id}', [BodyTypeController::class, 'updateStatus'])->name('body-types.status.update');

            // Fuel Types
            Route::resource('fuel-types', FuelTypeController::class);
            Route::get('fuel-types/status/{id}', [FuelTypeController::class, 'updateStatus'])->name('fuel-types.status.update');

            // Features
            Route::resource('features', FeatureController::class);
            Route::get('features/status/{id}', [FeatureController::class, 'updateStatus'])->name('features.status.update');

            // Car Listings
            Route::resource('car-listings', DashboardCarListingController::class);
            Route::post('car-listings/status/{id}', [DashboardCarListingController::class, 'updateStatus'])->name('car-listings.status.update');
            Route::get('archived-car-listings', [ArchivedCarListingController::class, 'index'])->name('archived-car-listings.index');
            Route::delete('archived-car-listings/destroy/{id}', [ArchivedCarListingController::class, 'destroy'])->name('archived-car-listings.destroy');
            Route::get('archived-car-listings/restore/{id}', [ArchivedCarListingController::class, 'restoreCarListing'])->name('archived-car-listings.restore');

        });
        */
    });

// });