import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_flutter/constants.dart';
import 'package:tiktok_clone_flutter/models/comment/comment.dart';
import 'package:tiktok_clone_flutter/providers/provider.dart';

class CommentViewModel {
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  Future<String> postComment(String postId, String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        var uid = _ref.watch(userProvider).uid;

        DocumentSnapshot userDoc =
            await firestore.collection(FirebaseIds.users.name).doc(uid).get();

        var allDocs = await firestore
            .collection(FirebaseIds.videos.name)
            .doc(postId)
            .collection(FirebaseIds.comments.name)
            .get();

        int len = allDocs.docs.length;

        Comment comment = Comment(
          username: (userDoc.data() as dynamic)['name'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: (userDoc.data() as dynamic)['profilePhoto'],
          uid: _ref.watch(userProvider).uid,
          id: 'Comment $len',
        );

        await firestore
            .collection(FirebaseIds.videos.name)
            .doc(postId)
            .collection(FirebaseIds.comments.name)
            .doc('Comment $len')
            .set(comment.toJson());

        DocumentSnapshot doc = await firestore
            .collection(FirebaseIds.videos.name)
            .doc(postId)
            .get();

        await firestore.collection(FirebaseIds.videos.name).doc(postId).update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });

        return 'Succeeded to post the comment';
      } else {
        return 'Comment is empty';
      }
    } catch (e) {
      return e.toString();
    }
  }

  void likeComment(String postId, String id) async {
    var uid = _ref.watch(userProvider).uid;
    var docRef = firestore
        .collection(FirebaseIds.videos.name)
        .doc(postId)
        .collection(FirebaseIds.comments.name)
        .doc(id);

    DocumentSnapshot doc = await docRef.get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await docRef.update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await docRef.update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
