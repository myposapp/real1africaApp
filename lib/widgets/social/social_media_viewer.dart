import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../models/social_post.dart';

/// Full-screen, swipeable viewer for a post's images and videos.
class SocialMediaViewer extends StatefulWidget {
  final List<SocialMedia> media;
  final int initialIndex;

  const SocialMediaViewer({
    super.key,
    required this.media,
    this.initialIndex = 0,
  });

  static Future<void> open(
    BuildContext context,
    List<SocialMedia> media, {
    int initialIndex = 0,
  }) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) =>
            SocialMediaViewer(media: media, initialIndex: initialIndex),
      ),
    );
  }

  @override
  State<SocialMediaViewer> createState() => _SocialMediaViewerState();
}

class _SocialMediaViewerState extends State<SocialMediaViewer> {
  late final PageController _controller;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        title: widget.media.length > 1
            ? Text(
                '${_index + 1} / ${widget.media.length}',
                style: const TextStyle(color: Colors.white, fontSize: 15),
              )
            : null,
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.media.length,
        onPageChanged: (i) => setState(() => _index = i),
        itemBuilder: (context, i) {
          final item = widget.media[i];
          if (item.isVideo) {
            return _VideoPage(url: item.fullUrl, isActive: i == _index);
          }
          return InteractiveViewer(
            maxScale: 4,
            child: Center(
              child: Image.network(
                item.fullUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                errorBuilder: (_, _, _) => const Icon(
                  Icons.broken_image_outlined,
                  color: Colors.white54,
                  size: 48,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _VideoPage extends StatefulWidget {
  final String url;
  final bool isActive;

  const _VideoPage({required this.url, required this.isActive});

  @override
  State<_VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<_VideoPage> {
  late final VideoPlayerController _controller;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..setLooping(true);
    _controller
        .initialize()
        .then((_) {
          if (!mounted) return;
          setState(() {});
          if (widget.isActive) _controller.play();
        })
        .catchError((_) {
          if (mounted) setState(() => _hasError = true);
        });
  }

  @override
  void didUpdateWidget(covariant _VideoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isActive && _controller.value.isPlaying) _controller.pause();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return const Center(
        child: Text(
          'Could not play this video.',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }
    if (!_controller.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return GestureDetector(
      onTap: () => setState(() {
        _controller.value.isPlaying ? _controller.pause() : _controller.play();
      }),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
          if (!_controller.value.isPlaying)
            const CircleAvatar(
              radius: 32,
              backgroundColor: Colors.black45,
              child: Icon(Icons.play_arrow, color: Colors.white, size: 40),
            ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ],
      ),
    );
  }
}
