import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_flutter/constants.dart';
import 'package:tiktok_clone_flutter/providers/routerProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone_flutter/widgets/dummy.dart'
    if (dart.library.html) 'package:image_picker_for_web/image_picker_for_web.dart';

// import 'package:image_picker_for_web/image_picker_for_web.dart';

class AddVideoView extends ConsumerWidget {
  const AddVideoView({Key? key}) : super(key: key);

  pickVideo(WidgetRef ref, ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(
      source: src,
      preferredCameraDevice: kIsWeb ? CameraDevice.front : CameraDevice.rear,
    );
    if (video != null) {
      ref.watch(routerProvider).go("/upload?videoPath=${video.path}");
    }
  }

  showOptionDialog(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () => pickVideo(ref, ImageSource.gallery, context),
            child: Row(
              children: const [
                Icon(Icons.image),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    "Gallery",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => pickVideo(ref, ImageSource.camera, context),
            child: Row(
              children: const [
                Icon(Icons.camera_alt),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    "Camera",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: Row(
              children: const [
                Icon(Icons.cancel),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showOptionDialog(context, ref),
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(color: buttonColor),
            child: const Center(
              child: Text(
                "Add Video",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
