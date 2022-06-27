import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone_flutter/constants.dart';
import 'package:tiktok_clone_flutter/models/comment/comment.dart';
import 'package:tiktok_clone_flutter/models/profile_user/profile_user.dart';
import 'package:tiktok_clone_flutter/models/snackbar_state/snackbar_state.dart';
import 'package:tiktok_clone_flutter/models/user_state/user_state.dart';
import 'package:tiktok_clone_flutter/models/video/video.dart';
import 'package:tiktok_clone_flutter/repository/video_dao.dart';

//-------------------------------------------------------------------------
// Firebase
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangeProvider = StreamProvider<User?>(
    (ref) => ref.watch(firebaseAuthProvider).authStateChanges());

final databaseProvider = Provider<FirebaseFirestore?>((ref) {
  final auth = ref.watch(authStateChangeProvider);

  if (auth.value?.uid != null) {
    return FirebaseFirestore.instance;
  }

  return null;
});

//-------------------------------------------------------------------------
// User

final userProvider = StateProvider<UserState>(
  (ref) => UserState(
    name: "",
    profilePhoto: "",
    email: "",
    uid: "",
  ),
);

//-------------------------------------------------------------------------
// Search
final typedUserProvider = StateProvider<String>((ref) => "");

final searchedUsersStreamProvider = StreamProvider.autoDispose<List<UserState>>(
  (ref) {
    final typedUser = ref.watch(typedUserProvider);
    // return FirebaseFirestore.instance
    //     .collection(FirebaseIds.users.name)
    //     .where('name', isGreaterThanOrEqualTo: typedUser)
    //     .snapshots()
    //     .map((query) => query.docs
    //         .map((doc) => doc.data())
    //         .map((data) => UserState.fromJson(data))
    //         .toList());

    print("Typed user name: $typedUser");

    var chara = typedUser.isNotEmpty
        ? String.fromCharCode(typedUser.codeUnitAt(typedUser.length - 1) + 1)
        : "";
    var subStr = typedUser.isNotEmpty
        ? typedUser.substring(0, typedUser.length - 1) +
            String.fromCharCode(typedUser.codeUnitAt(typedUser.length - 1) + 1)
        : "";
    print(subStr);
    // print(chara);

    return FirebaseFirestore.instance
        .collection(FirebaseIds.users.name)
        .where(
          'name',
          isGreaterThanOrEqualTo: typedUser,
          isLessThan: subStr,
        )
        .snapshots()
        .map((query) => query.docs.map((doc) => doc.data()).map((data) {
              print("Firestore query: $data");
              var newData = UserState.fromJson(data);
              print("Firesotre new data: $newData");
              return newData;
            }).toList());
  },
);

//-------------------------------------------------------------------------
// Profile
final profileUserUidProvider = StateProvider<String>((ref) => "");

final profileUserProvider = StateProvider<ProfileUser>((ref) => ProfileUser(
      name: "",
      profilePhoto: "",
      thumbnails: [],
      likes: "",
      followers: "",
      following: "",
      isFollowing: false,
    ));

//-------------------------------------------------------------------------
// Video

final videoDaoProvider = StateProvider<VideoDao>(
  (ref) => VideoDao(),
);

final videoListStreamProvider = StreamProvider.autoDispose<List<Video>>(
  (ref) {
    return FirebaseFirestore.instance
        .collection(FirebaseIds.videos.name)
        .snapshots()
        .map((query) => query.docs
            .map((doc) => doc.data())
            .map((data) => Video.fromJson(data))
            .toList());

    // final snapshots = FirebaseFirestore.instance
    //     .collection(FirebaseIds.videos.name)
    //     .get()
    //     .asStream();

    // await for (final query in snapshots) {
    //   for (final doc in query.docs) {
    //     yield Video.fromJson(doc.data());
    //   }
    // }
  },
);

//-------------------------------------------------------------------------
// Comment
final commentsStreamProvider =
    StreamProvider.autoDispose.family<List<Comment>, String>(
  (ref, postId) {
    // return FirebaseFirestore.instance
    //     .collection(FirebaseIds.videos.name)
    //     .doc(postId)
    //     .collection(FirebaseIds.comments.name)
    //     .snapshots()
    //     .map((QuerySnapshot query) {
    //   List<Comment> retValue = [];
    //   for (var doc in query.docs) {
    //     retValue.add(Comment.fromJson(doc.data() as Map<String, dynamic>));
    //   }
    //   return retValue;
    // });

    return FirebaseFirestore.instance
        .collection(FirebaseIds.videos.name)
        .doc(postId)
        .collection(FirebaseIds.comments.name)
        .snapshots()
        .map((query) => query.docs
            .map((doc) => doc.data())
            .map((data) => Comment.fromJson(data))
            .toList());

    // final snapshots = FirebaseFirestore.instance
    //     .collection(FirebaseIds.videos.name)
    //     .doc(postId)
    //     .collection(FirebaseIds.comments.name)
    //     .get()
    //     .asStream();

    // await for (final query in snapshots) {
    //   for (final doc in query.docs) {
    //     yield Comment.fromJson(doc.data());
    //   }
    // }
  },
);

//-------------------------------------------------------------------------
// General
final bottomNavPageProvider = StateProvider<int>((ref) => 0);

final loadingProvider = StateProvider<bool>((ref) => false);

final pickedImageProvider = StateProvider<XFile?>((ref) => null);

final snackBarStateProvider = StateProvider<SnackBarState>(
    (ref) => SnackBarState(showSnackBar: false, message: ""));
