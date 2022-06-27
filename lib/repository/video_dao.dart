import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone_flutter/models/video/video.dart';

class VideoDao {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection("");

  void saveVideo(Video video) {
    _collection.add(video);
  }

  Stream<QuerySnapshot> getSnapshots() {
    return _collection.snapshots();
  }
}
