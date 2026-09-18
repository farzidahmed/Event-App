import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:llr/assets_helper/app_font.dart';
import 'package:llr/assets_helper/color.dart';
import 'package:llr/helpers/navigation_service.dart';
import 'package:video_player/video_player.dart';

class AlbumMediaScreen extends StatefulWidget {
  final List<dynamic> documents;
  final int initialIndex;

  const AlbumMediaScreen({
    super.key,
    required this.documents,
    this.initialIndex = 0,
  });

  @override
  State<AlbumMediaScreen> createState() => _AlbumMediaScreenState();
}

class _AlbumMediaScreenState extends State<AlbumMediaScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < widget.documents.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.documents.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => NavigationService.goBack,
          ),
        ),
        body: const Center(
          child: Text(
            'No media available',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xff1A1B1F),
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.documents.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final document = widget.documents[index];
                String url = '';
                if (document is String) {
                  url = document;
                } else if (document is Map) {
                  url = document['file_url']?.toString() ?? document.toString();
                } else {
                  try {
                    url =
                        (document as dynamic).fileUrl?.toString() ??
                        document.toString();
                  } catch (_) {
                    url = document.toString();
                  }
                }
                final isVideo =
                    url.toLowerCase().endsWith('.mp4') ||
                    url.toLowerCase().endsWith('.mov') ||
                    url.toLowerCase().endsWith('.mkv');

                return isVideo
                    ? _VideoPlayerItem(
                      videoUrl: url,
                      isActive: _currentIndex == index,
                    )
                    : CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.contain,
                      placeholder:
                          (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                      errorWidget:
                          (context, url, error) => const Center(
                            child: Icon(Icons.error, color: Colors.white),
                          ),
                    );
              },
            ),

            // Top Bar
            Positioned(
              top: 16.h,
              left: 16.w,
              right: 16.w,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => NavigationService.goBack,
                    child: Icon(Icons.close, color: Colors.white, size: 24.sp),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "${_currentIndex + 1} of ${widget.documents.length}",
                        style: TextFontStyle.headline18cffffroboto.copyWith(
                          color: AppColor.cFFFFFF,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24.sp,
                  ), // Balance the close icon for centering
                ],
              ),
            ),

            // Left Arrow
            if (_currentIndex > 0)
              Positioned(
                left: 16.w,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: _previousPage,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // Right Arrow
            if (_currentIndex < widget.documents.length - 1)
              Positioned(
                right: 16.w,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: _nextPage,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.w),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final bool isActive;

  const _VideoPlayerItem({required this.videoUrl, this.isActive = true});

  @override
  State<_VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<_VideoPlayerItem>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isBuffering = false;
  bool _hasError = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() async {
    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      _controller.addListener(_videoListener);

      await _controller.initialize();
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
        if (widget.isActive) {
          _controller.play();
          setState(() {
            _isPlaying = true;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isInitialized = true;
        });
      }
    }
  }

  void _videoListener() {
    if (!mounted) return;
    final isPlaying = _controller.value.isPlaying;
    final isBuffering = _controller.value.isBuffering;
    final hasError = _controller.value.hasError;

    if (isPlaying != _isPlaying ||
        isBuffering != _isBuffering ||
        hasError != _hasError) {
      setState(() {
        _isPlaying = isPlaying;
        _isBuffering = isBuffering;
        _hasError = hasError;
      });
    }
  }

  @override
  void didUpdateWidget(covariant _VideoPlayerItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isInitialized) return;

    if (!oldWidget.isActive && widget.isActive) {
      if (!_controller.value.isPlaying) {
        if (_controller.value.position >= _controller.value.duration) {
          _controller.seekTo(Duration.zero);
        }
        _controller.play();
      }
    } else if (oldWidget.isActive && !widget.isActive) {
      if (_controller.value.isPlaying) {
        _controller.pause();
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (!_isInitialized || _hasError) return;
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        if (_controller.value.position >= _controller.value.duration) {
          _controller.seekTo(Duration.zero);
        }
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (!_isInitialized) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 12.h),
              Text(
                "Loading video...",
                style: TextStyle(color: Colors.white70, fontSize: 13.sp),
              ),
            ],
          ),
        ),
      );
    }

    if (_hasError || _controller.value.hasError) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                color: Colors.white70,
                size: 48.sp,
              ),
              SizedBox(height: 8.h),
              Text(
                "Failed to play video",
                style: TextStyle(color: Colors.white70, fontSize: 13.sp),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _togglePlayPause,
      child: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: AspectRatio(
                aspectRatio:
                    _controller.value.aspectRatio > 0
                        ? _controller.value.aspectRatio
                        : 16 / 9,
                child: VideoPlayer(_controller),
              ),
            ),

            // Loading / Buffering indicator
            if (_isBuffering)
              Container(
                color: Colors.black26,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),

            // Play / Pause Icon overlay when paused and not buffering
            if (!_isPlaying && !_isBuffering)
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.8),
                    width: 1.5.w,
                  ),
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 44.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
