import 'package:chewie/chewie.dart';
import 'package:ecommerce/config/urls.dart';
import 'package:ecommerce/presentation/resources/assets_manager.dart';
import 'package:ecommerce/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  final String videoUrl;

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late ChewieController _controller;

  @override
  void initState() {
    _initializeChewieController();
    super.initState();
  }

  void _initializeChewieController() {
    print('Video URL is:===>${Urls.filesUrl + widget.videoUrl}');
    final videoPlayerController = VideoPlayerController.network(
      Urls.filesUrl + widget.videoUrl,
      // httpHeaders: {
      //   'Accept': '*/*',
      //   'Connection': 'keep-alive',
      //   'Accept-Encoding': 'gzip, deflate, br',
      // },
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized,
        // even before the play button has been pressed.
        setState(() {});
      });

    _controller = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      aspectRatio: 16 / 9,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.black),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Chewie(
        controller: _controller,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
