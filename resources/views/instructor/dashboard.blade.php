@extends('layouts.app.master')

@section('title', 'Instructor Dashboard')

@section('css')
@endsection

@section('content')
<div class="container-fluid">
    <div class="page-title">
        <div class="row">
            <div class="col-sm-6">
                <h3>Instructor Dashboard</h3>
            </div>
            <div class="col-sm-6">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">                                       
                        <svg class="stroke-icon">
                            <use href="{{asset('AdminAssets/svg/icon-sprite.svg')}}#stroke-home"></use>
                        </svg></a></li>
                    <li class="breadcrumb-item">Dashboard</li>
                    <li class="breadcrumb-item active">Instructor</li>
                </ol>
            </div>
        </div>
    </div>
</div>

<!-- Container-fluid starts-->
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-6 col-md-12">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Welcome, Instructor!</h5>
                </div>
                <div class="card-body">
                    <p>Welcome to your instructor dashboard. From here you can manage your courses, students, and teaching materials.</p>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card text-center">
                                <div class="card-body">
                                    <h5 class="card-title">Courses</h5>
                                    <p class="card-text">Manage your courses</p>
                                    <a href="#" class="btn btn-primary">View Courses</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card text-center">
                                <div class="card-body">
                                    <h5 class="card-title">Students</h5>
                                    <p class="card-text">View student progress</p>
                                    <a href="#" class="btn btn-success">View Students</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-lg-6 col-md-12">
            <div class="card">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">Quick Actions</h5>
                </div>
                <div class="card-body">
                    <div class="list-group">
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1">Create New Course</h6>
                            </div>
                            <p class="mb-1">Start creating a new course for your students.</p>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1">Grade Assignments</h6>
                            </div>
                            <p class="mb-1">Review and grade pending assignments.</p>
                        </a>
                        <a href="#" class="list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-between">
                                <h6 class="mb-1">Manage Resources</h6>
                            </div>
                            <p class="mb-1">Upload and manage course materials.</p>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@section('script')
@endsection

