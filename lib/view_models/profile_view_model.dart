import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_flutter/constants.dart';
import 'package:tiktok_clone_flutter/models/profile_user/profile_user.dart';
import 'package:tiktok_clone_flutter/providers/provider.dart';

class ProfileViewModel {
  late WidgetRef _ref;
  String _profileUid = "";

  void setRef(WidgetRef ref) {
    _ref = ref;
    // getUserData();
  }

  void getUserData() async {
    final profileUid = _ref.read(profileUserUidProvider);
    final authUid = _ref.read(userProvider).uid;

    print("Profile User UID: $profileUid");
    print("Current User UID: $authUid");

    if (profileUid.isEmpty || _profileUid == profileUid) {
      return;
    }

    _profileUid = profileUid;

    try {
      List<String> thumbnails = [];
      var myVideos = await firestore
          .collection(FirebaseIds.videos.name)
          .where('uid', isEqualTo: profileUid)
          .get();

      for (var doc in myVideos.docs) {
        thumbnails.add((doc.data() as dynamic)['thumbnail']);
      }

      DocumentSnapshot userDoc = await firestore
          .collection(FirebaseIds.users.name)
          .doc(profileUid)
          .get();
      final userData = userDoc.data()! as dynamic;
      String name = userData['name'];
      String profilePhoto = userData['profilePhoto'] ?? "";
      int likes = 0;
      int followers = 0;
      int following = 0;
      bool isFollowing = false;

      print("User Data: $userData");

      for (var item in myVideos.docs) {
        likes += (item.data()['Likes'] as List).length;
      }
      var followerDoc = await firestore
          .collection(FirebaseIds.users.name)
          .doc(profileUid)
          .collection('followers')
          .get();
      var followingDoc = await firestore
          .collection(FirebaseIds.users.name)
          .doc(profileUid)
          .collection('following')
          .get();
      followers = followerDoc.docs.length;
      following = followingDoc.docs.length;

      firestore
          .collection(FirebaseIds.users.name)
          .doc(profileUid)
          .collection('followers')
          .doc(authUid)
          .get()
          .then((value) {
        isFollowing = value.exists;
      });

      var profileUser = ProfileUser(
        name: name,
        profilePhoto: profilePhoto,
        thumbnails: thumbnails,
        likes: likes.toString(),
        followers: followers.toString(),
        following: following.toString(),
        isFollowing: isFollowing,
      );

      print("Profile User Data: $profileUser");

      _ref.watch(profileUserProvider.notifier).update((state) => profileUser);
    } catch (e) {
      print(e.toString());
    }
  }

  void followUser() async {
    var profileUid = _ref.watch(profileUserUidProvider);
    var authUserUid = _ref.watch(userProvider).uid;

    var doc = await firestore
        .collection(FirebaseIds.users.name)
        .doc(profileUid)
        .collection('followers')
        .doc(authUserUid)
        .get();

    if (!doc.exists) {
      await firestore
          .collection(FirebaseIds.users.name)
          .doc(profileUid)
          .collection('followers')
          .doc(authUserUid)
          .set({});

      await firestore
          .collection(FirebaseIds.users.name)
          .doc(profileUid)
          .collection('following')
          .doc(authUserUid)
          .set({});

      _ref.watch(profileUserProvider.notifier).update((state) => state.copyWith(
          followers: (int.parse(state.followers) + 1).toString()));
    } else {
      await firestore
          .collection(FirebaseIds.users.name)
          .doc(profileUid)
          .collection('followers')
          .doc(authUserUid)
          .delete();

      await firestore
          .collection(FirebaseIds.users.name)
          .doc(profileUid)
          .collection('following')
          .doc(authUserUid)
          .delete();

      _ref.watch(profileUserProvider.notifier).update((state) => state.copyWith(
          followers: (int.parse(state.followers) - 1).toString()));
    }

    _ref
        .watch(profileUserProvider.notifier)
        .update((state) => state.copyWith(isFollowing: !state.isFollowing));
  }
}
