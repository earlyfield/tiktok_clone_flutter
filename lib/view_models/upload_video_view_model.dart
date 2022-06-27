import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_flutter/constants.dart';
import 'package:tiktok_clone_flutter/models/video/video.dart';
import 'package:tiktok_clone_flutter/providers/provider.dart';
import 'package:tiktok_clone_flutter/providers/routerProvider.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoViewModel {
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  _compressVideo(String videoPath) async {
    final compressVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference firebaseRef =
        firebaseStorage.ref().child(FirebaseIds.videos.name).child(id);

    UploadTask uploadTask =
        firebaseRef.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference firebaseRef = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = firebaseRef.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String songName, String caption, String videoPath) async {
    _ref.watch(loadingProvider.notifier).update((state) => true);

    try {
      String uid = _ref.read(userProvider).uid;
      DocumentSnapshot userDoc =
          await firestore.collection(FirebaseIds.users.name).doc(uid).get();

      var allDocs = await firestore.collection(FirebaseIds.videos.name).get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        uid: uid,
        id: "Video $len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
      );

      await firestore.collection(FirebaseIds.videos.name).doc('Video $len').set(
            video.toJson(),
          );

      _ref.watch(routerProvider).pop();
    } catch (e) {
      print(e.toString());
    }

    _ref.watch(loadingProvider.notifier).update((state) => false);
  }
}
