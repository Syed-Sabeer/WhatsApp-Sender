<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use App\Models\User;
use Spatie\Permission\Models\Role; // ✅ Use Spatie's Role model

class RoleSeeder extends Seeder
{
    public function run(): void
    {
        // Create admin role
        $adminRole = Role::firstOrCreate([
            'name' => 'admin',
            'guard_name' => 'web',
        ]);

        // Create admin user
        $adminUser = User::firstOrCreate([
            'email' => 'admin@gmail.com'
        ], [
            'name' => 'Admin',
            'username' => 'admin',
            'password' => Hash::make('admin@gmail.com'),
        ]);

        // Assign the role to the user
        $adminUser->assignRole($adminRole); // ✅ This creates entry in model_has_roles
    }
}
