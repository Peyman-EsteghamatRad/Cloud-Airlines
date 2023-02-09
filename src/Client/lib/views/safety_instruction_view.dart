import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

/*
  This View displays a video player for playing a Safety Instruction Video,
  which can be stopped or skipped through with control tools at the bottom.
 */

class SafetyInstructions extends StatefulWidget {
  const SafetyInstructions({Key? key}) : super(key: key);

  @override
  State<SafetyInstructions> createState() => _SafetyInstructionsState();
}

class _SafetyInstructionsState extends State<SafetyInstructions> {
  Chewie? videoWidget;

  @override
  void initState() {
    super.initState();
    initVideoWidget();
  }

  void initVideoWidget() async {
    final videoPlayerController =
        VideoPlayerController.asset('assets/safetyInstructions.mp4');
    await videoPlayerController.initialize();
    setState(() => videoWidget = Chewie(
        controller: ChewieController(
            videoPlayerController: videoPlayerController,
            autoPlay: true,
            allowFullScreen: false,
            showControlsOnInitialize: false,
            showOptions: false)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Safety Instructions'),
          centerTitle: true,
        ),
        body: Center(
          child: videoWidget ??
              const CircularProgressIndicator(
                color: Colors.black,
              ),
        ));
  }

  @override
  void dispose() {
    videoWidget?.controller.videoPlayerController.dispose();
    videoWidget?.controller.dispose();
    super.dispose();
  }
}
