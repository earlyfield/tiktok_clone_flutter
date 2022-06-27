import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_flutter/providers/provider.dart';
import 'package:tiktok_clone_flutter/view_models/upload_video_view_model.dart';
import 'package:tiktok_clone_flutter/widgets/text_input_field.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
import 'package:tiktok_clone_flutter/widgets/dummy.dart'
    if (dart.library.html) 'package:video_player_web/video_player_web.dart';

// import 'package:video_player_web/video_player_web.dart';

class ConfirmView extends ConsumerStatefulWidget {
  final String videoPath;
  ConfirmView({
    Key? key,
    required this.videoPath,
  }) : super(key: key);

  @override
  ConsumerState<ConfirmView> createState() => _ConfirmViewState();
}

class _ConfirmViewState extends ConsumerState<ConfirmView> {
  late VideoPlayerController controller;
  late File videoFile;
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  UploadVideoViewModel uploadVideoViewModel = UploadVideoViewModel();

  @override
  void initState() {
    super.initState();

    uploadVideoViewModel.setRef(ref);

    videoFile = File(widget.videoPath);
    controller = kIsWeb
        ? VideoPlayerController.network(widget.videoPath)
        : VideoPlayerController.file(videoFile);
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);

    VideoCompress.compressProgress$.subscribe((event) {
      print("progress: $event");
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(controller),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: _songController,
                      labelText: "Song Name",
                      icon: Icons.music_note,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                      controller: _captionController,
                      labelText: 'Caption',
                      icon: Icons.closed_caption,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () => uploadVideoViewModel.uploadVideo(
                      _songController.text,
                      _captionController.text,
                      widget.videoPath,
                    ),
                    child: ref.watch(loadingProvider)
                        ? CircularProgressIndicator()
                        : const Text(
                            'Share!',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
