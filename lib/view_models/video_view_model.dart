import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_flutter/constants.dart';
import 'package:tiktok_clone_flutter/providers/provider.dart';
import 'package:tiktok_clone_flutter/models/video/video.dart';

class VideoViewModel {
  late WidgetRef _ref;
  late List<Video> videoList;

  void setRef(WidgetRef ref) {
    _ref = ref;
    // _ref
    //     .watch(videoListStreamProvider)
    //     .when(data: data, error: error, loading: loading);
  }

  // static Stream<List<Video>> makeList(CollectionReference ref) {
  //   return ref.snapshots().map(
  //         (QuerySnapshot query) => query.docs.map(
  //           (doc) {
  //             var obj = doc.data();
  //             if (obj == null) {
  //               return Video(
  //                 username: "",
  //                 uid: "",
  //                 id: "",
  //                 likes: [],
  //                 commentCount: 0,
  //                 shareCount: 0,
  //                 songName: "",
  //                 caption: "",
  //                 videoUrl: "",
  //                 thumbnail: "",
  //                 profilePhoto: "",
  //               );
  //             }

  //             var map = obj as Map<String, dynamic>;
  //             return Video.fromJson(map);
  //           },
  //         ).toList(),
  //       );
  // }

  void likeVideo(String id) async {
    DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    var video = doc.data() as Video?;
    if (video == null) {
      return;
    }

    var uid = _ref.read(userProvider).uid;
    if (video.likes.contains(uid)) {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
