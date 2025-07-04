@extends('layouts.app.master')

@section('title', 'WhatsApp File Sender Dashboard')

<meta name="csrf-token" content="{{ csrf_token() }}">

@section('css')
<style>
    .dashboard-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }
    
    .status-card {
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 12px rgba(0,0,0,0.1);
        border: none;
        margin-bottom: 20px;
    }
    
    .status-card .card-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: #fff;
        border-radius: 12px 12px 0 0;
        border: none;
        padding: 1.25rem 1.5rem;
    }
    
    .upload-section {
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 12px rgba(0,0,0,0.1);
        padding: 2rem;
        margin-bottom: 20px;
    }
    
    .file-drop-zone {
        border: 2px dashed #ddd;
        border-radius: 8px;
        padding: 2rem;
        text-align: center;
        transition: all 0.3s ease;
        background: #fafafa;
    }
    
    .file-drop-zone.dragover {
        border-color: #667eea;
        background: #f0f4ff;
    }
    
    .file-list {
        margin-top: 1rem;
    }
    
    .file-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 0.75rem 1rem;
        background: #f8f9fa;
        border-radius: 8px;
        margin-bottom: 0.5rem;
        border-left: 4px solid #ddd;
    }
    
    .file-item.pending { border-left-color: #ffc107; }
    .file-item.sent { border-left-color: #28a745; }
    .file-item.failed { border-left-color: #dc3545; }
    
    .status-badge {
        padding: 0.25rem 0.75rem;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
    }
    
    .status-pending { background: #fff3cd; color: #856404; }
    .status-sent { background: #d4edda; color: #155724; }
    .status-failed { background: #f8d7da; color: #721c24; }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 1rem;
        margin-bottom: 1.5rem;
    }
    
    .stat-card {
        background: #fff;
        padding: 1.5rem;
        border-radius: 8px;
        text-align: center;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    
    .stat-number {
        font-size: 2rem;
        font-weight: bold;
        margin-bottom: 0.5rem;
    }
    
    .stat-label {
        color: #666;
        font-size: 0.9rem;
    }
    
    .progress-container {
        background: #f8f9fa;
        border-radius: 8px;
        padding: 1rem;
        margin: 1rem 0;
    }
    
    .progress-bar {
        height: 8px;
        background: #e9ecef;
        border-radius: 4px;
        overflow: hidden;
        margin: 0.5rem 0;
    }
    
    .progress-fill {
        height: 100%;
        background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        transition: width 0.3s ease;
    }
    
    .action-buttons {
        display: flex;
        gap: 0.5rem;
        flex-wrap: wrap;
        margin-top: 1rem;
    }
    
    .btn-primary-custom {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 0.75rem 1.5rem;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .btn-primary-custom:hover:not(:disabled) {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
    }
    
    .btn-primary-custom:disabled {
        background: #ccc;
        cursor: not-allowed;
        transform: none;
    }
    
    .btn-success-custom {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 0.75rem 1.5rem;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .btn-warning-custom {
        background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 0.75rem 1.5rem;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .btn-danger-custom {
        background: linear-gradient(135deg, #dc3545 0%, #e83e8c 100%);
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 0.75rem 1.5rem;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .connection-status {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        margin-bottom: 1rem;
    }
    
    .status-indicator {
        width: 12px;
        height: 12px;
        border-radius: 50%;
        display: inline-block;
    }
    
    .status-connected { background: #28a745; }
    .status-disconnected { background: #dc3545; }
    .status-initializing { background: #ffc107; }
    
    .qr-container {
        text-align: center;
        padding: 1.5rem;
        background: #f8f9fa;
        border-radius: 8px;
        margin: 1rem 0;
    }
    
    .qr-image {
        max-width: 200px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    
    .loading-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.5);
        display: flex;
        align-items: center;
        justify-content: center;
        z-index: 9999;
        opacity: 0;
        visibility: hidden;
        transition: all 0.3s ease;
    }
    
    .loading-overlay.show {
        opacity: 1;
        visibility: visible;
    }
    
    .loading-content {
        background: #fff;
        padding: 2rem;
        border-radius: 12px;
        text-align: center;
        box-shadow: 0 8px 32px rgba(0,0,0,0.3);
    }
    
    .spinner {
        width: 40px;
        height: 40px;
        border: 4px solid #f3f3f3;
        border-top: 4px solid #667eea;
        border-radius: 50%;
        animation: spin 1s linear infinite;
        margin: 0 auto 1rem;
    }
    
    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
    
    .log-container {
        max-height: 300px;
        overflow-y: auto;
        background: #f8f9fa;
        border-radius: 8px;
        padding: 1rem;
        margin-top: 1rem;
    }
    
    .log-entry {
        font-family: 'Courier New', monospace;
        font-size: 0.85rem;
        margin-bottom: 0.25rem;
        color: #333;
        padding: 0.25rem 0;
    }
    
    .files-table {
        background: #fff;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    
    .files-table th {
        background: #f8f9fa;
        padding: 1rem;
        font-weight: 600;
        text-align: left;
        border-bottom: 1px solid #dee2e6;
    }
    
    .files-table td {
        padding: 1rem;
        border-bottom: 1px solid #dee2e6;
    }
    
    .files-table tr:hover {
        background: #f8f9fa;
    }
</style>
@endsection

@section('content')
<div class="dashboard-container">
    <!-- Loading Overlay -->
    <div id="loading-overlay" class="loading-overlay">
        <div class="loading-content">
            <div class="spinner"></div>
            <h5 id="loading-message">Processing files...</h5>
            <p id="loading-details" class="text-muted">Please wait while we send your files</p>
        </div>
    </div>

    <!-- WhatsApp Connection Status -->
    <div class="card status-card">
                <div class="card-header">
            <h5 class="mb-0"><i class="fa fa-whatsapp me-2"></i>WhatsApp Connection Status</h5>
                </div>
                <div class="card-body">
            <div class="connection-status" id="connection-status">
                <span class="status-indicator status-disconnected"></span>
                <span>Checking connection...</span>
            </div>
            
            <div id="qr-container" class="qr-container" style="display:none;">
                <h6>📱 Scan QR Code to Connect</h6>
                <img id="qr-image" class="qr-image" src="" alt="QR Code">
                <p class="text-muted mt-2">Open WhatsApp on your phone and scan this QR code</p>
            </div>
            
            <div class="action-buttons">
                <button id="reconnect-btn" class="btn btn-warning-custom" style="display:none;">
                    <i class="fa fa-refresh me-1"></i>Reconnect
                </button>
            </div>
        </div>
    </div>

    <!-- File Upload Section -->
    <div class="upload-section">
        <h5 class="mb-3"><i class="fa fa-upload me-2"></i>Upload Files</h5>
        
                   <form id="file-upload-form" action="{{ route('files.upload') }}" method="POST" enctype="multipart/form-data">
    @csrf
            <div class="file-drop-zone" id="file-drop-zone">
                <i class="fa fa-cloud-upload fa-3x text-muted mb-3"></i>
                <h6>Drag & Drop files here or click to browse</h6>
                <p class="text-muted">File names should contain phone numbers (e.g., 1234567890_document.pdf)</p>
                <input type="file" id="file-input" name="files[]" multiple style="display: none;">
                <button type="button" class="btn btn-primary-custom mt-2" onclick="document.getElementById('file-input').click()">
                    <i class="fa fa-folder-open me-2"></i>Choose Files
                </button>
    </div>
            
            <div class="file-list" id="file-list"></div>
            
            <button type="submit" class="btn btn-primary-custom w-100 mt-3" id="send-files-btn" disabled>
                <i class="fa fa-paper-plane me-2"></i>Send Files
            </button>
</form>
    </div>

    <!-- File Statistics -->
    <div class="card status-card">
        <div class="card-header">
            <h5 class="mb-0"><i class="fa fa-chart-bar me-2"></i>File Statistics</h5>
    </div>
    <div class="card-body">
            <div class="stats-grid" id="stats-grid">
                <div class="stat-card">
                    <div class="stat-number" id="total-files">0</div>
                    <div class="stat-label">Total Files</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="pending-files">0</div>
                    <div class="stat-label">Pending</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="sent-files">0</div>
                    <div class="stat-label">Sent</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number" id="failed-files">0</div>
                    <div class="stat-label">Failed</div>
                </div>
            </div>
            
            <div class="progress-container" id="progress-container" style="display:none;">
                <h6>📊 Sending Progress</h6>
                <div class="progress-bar">
                    <div id="progress-fill" class="progress-fill" style="width: 0%"></div>
                </div>
                <p id="progress-text" class="mb-2">Ready to send files</p>
            </div>
            
            <div class="action-buttons">
                <button id="send-pending-btn" class="btn btn-success-custom">
                    <i class="fa fa-play me-1"></i>Send Pending Files
                </button>
                <button id="retry-failed-btn" class="btn btn-warning-custom">
                    <i class="fa fa-redo me-1"></i>Retry Failed Files
                </button>
                <button id="force-quit-btn" class="btn btn-danger-custom" style="display:none;">
                    <i class="fa fa-stop me-1"></i>Force Quit
                </button>
                <button id="clear-completed-btn" class="btn btn-secondary">
                    <i class="fa fa-trash me-1"></i>Clear Completed
                </button>
            </div>
        </div>
    </div>

    <!-- File List -->
    <div class="card status-card">
        <div class="card-header">
            <h5 class="mb-0"><i class="fa fa-list me-2"></i>File History</h5>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="files-table w-100" id="files-table">
                    <thead>
                        <tr>
                            <th>File Name</th>
                            <th>Phone Number</th>
                            <th>Status</th>
                            <th>Uploaded</th>
                        </tr>
                    </thead>
                    <tbody id="files-tbody">
                        <tr>
                            <td colspan="4" class="text-center text-muted">No files uploaded yet</td>
                        </tr>
                    </tbody>
                </table>
            </div>
    </div>
</div>

    <!-- Logs Section -->
    <div class="card status-card">
        <div class="card-header">
            <h5 class="mb-0"><i class="fa fa-terminal me-2"></i>System Logs</h5>
                </div>
        <div class="card-body">
            <div class="log-container">
                <div id="log-list"></div>
            </div>
        </div>
    </div>
</div>
@endsection

@section('script')
<script>
class WhatsAppDashboard {
    constructor() {
        this.initializeElements();
        this.initializeEventListeners();
        this.startPolling();
        this.loadFileStatus();
    }

    initializeElements() {
        this.elements = {
            loadingOverlay: document.getElementById('loading-overlay'),
            loadingMessage: document.getElementById('loading-message'),
            loadingDetails: document.getElementById('loading-details'),
            connectionStatus: document.getElementById('connection-status'),
            qrContainer: document.getElementById('qr-container'),
            qrImage: document.getElementById('qr-image'),
            fileInput: document.getElementById('file-input'),
            fileDropZone: document.getElementById('file-drop-zone'),
            fileList: document.getElementById('file-list'),
            sendFilesBtn: document.getElementById('send-files-btn'),
            progressContainer: document.getElementById('progress-container'),
            progressFill: document.getElementById('progress-fill'),
            progressText: document.getElementById('progress-text'),
            statsGrid: document.getElementById('stats-grid'),
            filesTable: document.getElementById('files-table'),
            filesTbody: document.getElementById('files-tbody'),
            logList: document.getElementById('log-list'),
            sendPendingBtn: document.getElementById('send-pending-btn'),
            retryFailedBtn: document.getElementById('retry-failed-btn'),
            forceQuitBtn: document.getElementById('force-quit-btn'),
            clearCompletedBtn: document.getElementById('clear-completed-btn'),
            reconnectBtn: document.getElementById('reconnect-btn')
        };

        this.files = [];
        this.isTaskRunning = false;
        this.statusInterval = null;
        this.fileStatusInterval = null;
    }

    initializeEventListeners() {
        // File upload events
        this.elements.fileInput.addEventListener('change', (e) => this.handleFileSelect(e));
        this.elements.fileDropZone.addEventListener('click', () => this.elements.fileInput.click());
        this.elements.fileDropZone.addEventListener('dragover', (e) => this.handleDragOver(e));
        this.elements.fileDropZone.addEventListener('drop', (e) => this.handleDrop(e));
        
        // Form submission
        document.getElementById('file-upload-form').addEventListener('submit', (e) => this.handleFormSubmit(e));
        
        // Action buttons
        this.elements.sendPendingBtn.addEventListener('click', () => this.sendPendingFiles());
        this.elements.retryFailedBtn.addEventListener('click', () => this.retryFailedFiles());
        this.elements.forceQuitBtn.addEventListener('click', () => this.forceQuit());
        this.elements.clearCompletedBtn.addEventListener('click', () => this.clearCompletedFiles());
        this.elements.reconnectBtn.addEventListener('click', () => this.reconnect());
    }

    handleFileSelect(event) {
        this.files = Array.from(event.target.files);
        this.renderFileList();
        this.elements.sendFilesBtn.disabled = this.files.length === 0;
    }

    handleDragOver(event) {
        event.preventDefault();
        this.elements.fileDropZone.classList.add('dragover');
    }

    handleDrop(event) {
        event.preventDefault();
        this.elements.fileDropZone.classList.remove('dragover');
        this.files = Array.from(event.dataTransfer.files);
        this.elements.fileInput.files = event.dataTransfer.files;
        this.renderFileList();
        this.elements.sendFilesBtn.disabled = this.files.length === 0;
    }

    renderFileList() {
        this.elements.fileList.innerHTML = '';
        this.files.forEach((file, index) => {
            const div = document.createElement('div');
            div.className = 'file-item pending';
            div.innerHTML = `
                <span><i class='fa fa-file me-2 text-primary'></i>${file.name}</span>
                <button type='button' class='btn btn-sm btn-outline-danger' onclick='dashboard.removeFile(${index})'>
                    <i class='fa fa-times'></i>
                </button>
            `;
            this.elements.fileList.appendChild(div);
        });
    }

    removeFile(index) {
        this.files.splice(index, 1);
        this.renderFileList();
        this.elements.fileInput.value = '';
        this.elements.sendFilesBtn.disabled = this.files.length === 0;
    }

    async handleFormSubmit(event) {
        if (this.isTaskRunning) {
            event.preventDefault();
            alert('Please wait for current tasks to complete before uploading new files.');
            return;
        }

        if (this.files.length === 0) {
            event.preventDefault();
            alert('Please select files to upload.');
            return;
        }

        this.showLoading('Uploading files...', 'Please wait while we process your files');
    }

    showLoading(message, details) {
        this.elements.loadingMessage.textContent = message;
        this.elements.loadingDetails.textContent = details;
        this.elements.loadingOverlay.classList.add('show');
    }

    hideLoading() {
        this.elements.loadingOverlay.classList.remove('show');
    }

    async fetchWhatsAppStatus() {
        try {
            const response = await fetch('/whatsapp/status');
            const data = await response.json();
            this.updateConnectionStatus(data);
        } catch (error) {
            console.error('Error fetching status:', error);
        }
    }

    updateConnectionStatus(data) {
        const statusElement = this.elements.connectionStatus;
        const indicator = statusElement.querySelector('.status-indicator');
        const text = statusElement.querySelector('span:last-child');

        // Update status indicator
        indicator.className = 'status-indicator';
        if (data.initializing) {
            indicator.classList.add('status-initializing');
            text.textContent = 'Initializing WhatsApp client...';
        } else if (data.connected) {
            indicator.classList.add('status-connected');
            text.textContent = '✅ WhatsApp is connected';
        } else {
            indicator.classList.add('status-disconnected');
            text.textContent = '❌ Not connected';
        }

        // Update QR code
        if (!data.connected && data.qr) {
            this.elements.qrContainer.style.display = 'block';
            this.elements.qrImage.src = data.qr;
        } else {
            this.elements.qrContainer.style.display = 'none';
        }

        // Update task progress
        this.isTaskRunning = data.taskRunning;
        if (data.taskRunning || data.queueLength > 0) {
            this.elements.progressContainer.style.display = 'block';
            this.elements.sendFilesBtn.disabled = true;
            this.elements.forceQuitBtn.style.display = 'inline-block';
            
            // Update progress bar
            if (data.progress !== undefined) {
                this.elements.progressFill.style.width = `${data.progress}%`;
            }
            
            if (data.currentTask) {
                this.elements.progressText.textContent = `Processing: ${data.currentTask.description}`;
            } else if (data.totalFiles > 0) {
                const completed = (data.sentFiles || 0) + (data.failedFiles || 0);
                this.elements.progressText.textContent = `Progress: ${completed}/${data.totalFiles} files processed`;
            } else {
                this.elements.progressText.textContent = `Queue length: ${data.queueLength}`;
            }
        } else {
            this.elements.progressContainer.style.display = 'none';
            this.elements.sendFilesBtn.disabled = this.files.length === 0;
            this.elements.forceQuitBtn.style.display = 'none';
            this.elements.progressFill.style.width = '0%';
        }

        // Show reconnect button if disconnected
        this.elements.reconnectBtn.style.display = (!data.connected && !data.initializing) ? 'inline-block' : 'none';

        // Update logs
        this.updateLogs(data.logs);
    }

    updateLogs(logs) {
        this.elements.logList.innerHTML = '';
        logs.slice(0, 20).forEach(log => {
            const div = document.createElement('div');
            div.className = 'log-entry';
            div.textContent = log;
            this.elements.logList.appendChild(div);
        });
    }

    async loadFileStatus() {
        try {
            const response = await fetch('/files/status');
            const data = await response.json();
            this.updateFileStats(data.stats);
            this.updateFilesTable(data.files);
        } catch (error) {
            console.error('Error loading file status:', error);
        }
    }

    updateFileStats(stats) {
        document.getElementById('total-files').textContent = stats.total;
        document.getElementById('pending-files').textContent = stats.pending;
        document.getElementById('sent-files').textContent = stats.sent;
        document.getElementById('failed-files').textContent = stats.failed;
    }

    updateFilesTable(files) {
        if (files.length === 0) {
            this.elements.filesTbody.innerHTML = '<tr><td colspan="4" class="text-center text-muted">No files uploaded yet</td></tr>';
            return;
        }

        this.elements.filesTbody.innerHTML = '';
        files.forEach(file => {
            const row = document.createElement('tr');
            row.className = `file-item ${file.status}`;
            
            const fileName = file.file_path.split('/').pop();
            const statusBadge = this.getStatusBadge(file.status);
            const uploadDate = new Date(file.created_at).toLocaleString();
            
            row.innerHTML = `
                <td><i class='fa fa-file me-2'></i>${fileName}</td>
                <td>${file.mobile_number}</td>
                <td>${statusBadge}</td>
                <td>${uploadDate}</td>
            `;
            
            this.elements.filesTbody.appendChild(row);
        });
    }

    getStatusBadge(status) {
        const badges = {
            pending: '<span class="status-badge status-pending">Pending</span>',
            sent: '<span class="status-badge status-sent">Sent</span>',
            failed: '<span class="status-badge status-failed">Failed</span>'
        };
        return badges[status] || badges.pending;
    }

    async sendPendingFiles() {
        try {
            this.showLoading('Sending pending files...', 'Please wait while we send your pending files');
            
            const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || 
                             document.querySelector('input[name="_token"]')?.value;
            
            if (!csrfToken) {
                throw new Error('CSRF token not found');
            }
            
            const response = await fetch('/files/send-pending', {
                method: 'POST',
                headers: {
                    'X-CSRF-TOKEN': csrfToken,
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const result = await response.json();
            
            if (result.success) {
                alert(`Successfully queued ${result.count} pending files for sending`);
                this.loadFileStatus(); // Refresh file status
            } else {
                alert(result.message);
            }
        } catch (error) {
            console.error('Error sending pending files:', error);
            alert('Error sending pending files: ' + error.message);
        } finally {
            this.hideLoading();
        }
    }

    async retryFailedFiles() {
        try {
            this.showLoading('Retrying failed files...', 'Please wait while we retry your failed files');
            
            const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || 
                             document.querySelector('input[name="_token"]')?.value;
            
            if (!csrfToken) {
                throw new Error('CSRF token not found');
            }
            
            const response = await fetch('/files/retry-failed', {
                method: 'POST',
                headers: {
                    'X-CSRF-TOKEN': csrfToken,
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const result = await response.json();
            
            if (result.success) {
                alert(`Successfully queued ${result.count} failed files for retry`);
                this.loadFileStatus(); // Refresh file status
            } else {
                alert(result.message);
            }
        } catch (error) {
            console.error('Error retrying failed files:', error);
            alert('Error retrying failed files: ' + error.message);
        } finally {
            this.hideLoading();
        }
    }

    async forceQuit() {
        if (!confirm('Are you sure you want to force quit all tasks?')) {
            return;
        }

        try {
            const response = await fetch('/whatsapp/force-quit', {
                method: 'POST',
                headers: {
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
                    'Content-Type': 'application/json'
                }
            });

            if (response.ok) {
                this.elements.progressContainer.style.display = 'none';
                this.elements.sendFilesBtn.disabled = this.files.length === 0;
                this.elements.forceQuitBtn.style.display = 'none';
            }
        } catch (error) {
            console.error('Error force quitting:', error);
        }
    }

    async clearCompletedFiles() {
        if (!confirm('Are you sure you want to clear all completed files?')) {
            return;
        }

        try {
            const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || 
                             document.querySelector('input[name="_token"]')?.value;
            
            if (!csrfToken) {
                throw new Error('CSRF token not found');
            }
            
            const response = await fetch('/files/clear-completed', {
                method: 'POST',
                headers: {
                    'X-CSRF-TOKEN': csrfToken,
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const result = await response.json();
            
            if (result.success) {
                alert(`Successfully cleared ${result.count} completed files`);
                this.loadFileStatus();
            } else {
                alert(result.message);
            }
        } catch (error) {
            console.error('Error clearing completed files:', error);
            alert('Error clearing completed files: ' + error.message);
        }
    }

    async reconnect() {
        try {
            const response = await fetch('/whatsapp/reconnect', {
                method: 'POST',
                headers: {
                    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
                    'Content-Type': 'application/json'
                }
            });

            if (response.ok) {
                this.elements.reconnectBtn.style.display = 'none';
            }
        } catch (error) {
            console.error('Error reconnecting:', error);
        }
    }

    startPolling() {
        this.fetchWhatsAppStatus();
        this.statusInterval = setInterval(() => {
            this.fetchWhatsAppStatus();
        }, 3000);

        this.fileStatusInterval = setInterval(() => {
            this.loadFileStatus();
        }, 5000);
    }

    stopPolling() {
        if (this.statusInterval) {
            clearInterval(this.statusInterval);
        }
        if (this.fileStatusInterval) {
            clearInterval(this.fileStatusInterval);
        }
    }
}

// Initialize dashboard
const dashboard = new WhatsAppDashboard();
</script>
@endsection