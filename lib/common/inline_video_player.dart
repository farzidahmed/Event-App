import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class InlineVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final double? height;

  const InlineVideoPlayer({required this.videoUrl, this.height, super.key});

  @override
  State<InlineVideoPlayer> createState() => _InlineVideoPlayerState();
}

class _InlineVideoPlayerState extends State<InlineVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isBuffering = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      }).catchError((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      });

    _controller.addListener(_onVideoStateChanged);
  }

  void _onVideoStateChanged() {
    if (mounted) {
      final isPlaying = _controller.value.isPlaying;
      final isBuffering = _controller.value.isBuffering;
      if (isPlaying != _isPlaying || isBuffering != _isBuffering) {
        setState(() {
          _isPlaying = isPlaying;
          _isBuffering = isBuffering;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onVideoStateChanged);
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        if (_controller.value.isInitialized &&
            _controller.value.position >= _controller.value.duration) {
          _controller.seekTo(Duration.zero);
        }
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Container(
        height: widget.height ?? 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: const Center(
            child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    if (_controller.value.hasError) {
      return Container(
        height: widget.height ?? 200.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: const Center(
          child: Icon(Icons.error, color: Colors.white, size: 50),
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _togglePlayPause,
      child: Container(
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio > 0
                      ? _controller.value.aspectRatio
                      : 16 / 9,
                  child: VideoPlayer(_controller),
                ),
              ),
              if (_isBuffering)
                Container(
                  color: Colors.black26,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              if (!_isPlaying && !_isBuffering)
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 40.sp,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
