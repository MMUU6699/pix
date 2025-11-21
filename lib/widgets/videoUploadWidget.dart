import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:video_player/video_player.dart';
import 'package:pix/ui/theme/theme.dart';
import 'package:pix/l10n/app_localizations.dart';

class VideoUploadWidget extends StatefulWidget {
  final Function(File?) onVideoSelected;
  final double maxSizeMB;
  final int maxDurationSeconds;

  const VideoUploadWidget({
    Key? key,
    required this.onVideoSelected,
    this.maxSizeMB = 100.0, // 100MB max
    this.maxDurationSeconds = 300, // 5 minutes max
  }) : super(key: key);

  @override
  State<VideoUploadWidget> createState() => _VideoUploadWidgetState();
}

class _VideoUploadWidgetState extends State<VideoUploadWidget> {
  File? _selectedVideo;
  //VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        File videoFile = File(result.files.single.path!);
        
        // Check file size
        int fileSizeInBytes = await videoFile.length();
        double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
        
        if (fileSizeInMB > widget.maxSizeMB) {
          setState(() {
            _errorMessage = 'Video size exceeds ${widget.maxSizeMB}MB limit';
          });
          return;
        }

        // Initialize video player to check duration
        //VideoPlayerController tempController = //VideoPlayerController.file(videoFile);
        await tempController.initialize();
        
        Duration videoDuration = tempController.value.duration;
        tempController.dispose();
        
        if (videoDuration.inSeconds > widget.maxDurationSeconds) {
          setState(() {
            _errorMessage = 'Video duration exceeds ${widget.maxDurationSeconds ~/ 60} minutes limit';
          });
          return;
        }

        // If all checks pass, set the video
        await _setVideo(videoFile);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error selecting video: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _setVideo(File videoFile) async {
    // Dispose previous controller
    _controller?.dispose();
    
    setState(() {
      _selectedVideo = videoFile;
      _isInitialized = false;
    });

    // Initialize new controller
    _controller = //VideoPlayerController.file(videoFile);
    await _controller!.initialize();
    
    setState(() {
      _isInitialized = true;
    });

    widget.onVideoSelected(videoFile);
  }

  void _removeVideo() {
    _controller?.dispose();
    setState(() {
      _selectedVideo = null;
      _controller = null;
      _isInitialized = false;
      _errorMessage = null;
    });
    widget.onVideoSelected(null);
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    if (_selectedVideo == null) {
      return Column(
        children: [
          GestureDetector(
            onTap: _isLoading ? null : _pickVideo,
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey[300]!,
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.video_library_outlined,
                          size: 40,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          localizations.addVideo,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Max ${widget.maxSizeMB}MB, ${widget.maxDurationSeconds ~/ 60} min',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          if (_errorMessage != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red[600], size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Colors.red[600],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          // Video preview
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: _isInitialized && _controller != null
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: //VideoPlayer(_controller!),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (_controller!.value.isPlaying) {
                                _controller!.pause();
                              } else {
                                _controller!.play();
                              }
                              setState(() {});
                            },
                            icon: Icon(
                              _controller!.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
          ),
          // Video info and controls
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedVideo!.path.split('/').last,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      FutureBuilder<int>(
                        future: _selectedVideo!.length(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              children: [
                                Text(
                                  _formatFileSize(snapshot.data!),
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                if (_isInitialized && _controller != null) ...[
                                  Text(
                                    ' • ${_formatDuration(_controller!.value.duration)}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _removeVideo,
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey[600],
                  ),
                  tooltip: localizations.delete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}