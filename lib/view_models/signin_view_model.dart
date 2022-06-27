import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tiktok_clone_flutter/constants.dart';
import 'package:tiktok_clone_flutter/models/user_state/user_state.dart';
import 'package:tiktok_clone_flutter/providers/provider.dart';
import 'package:tiktok_clone_flutter/providers/routerProvider.dart';

class SigninViewModel {
  String from;
  late WidgetRef _ref;

  SigninViewModel(this.from);

  UserState get user => _ref.watch(userProvider);

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  Future<String> signin(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        var user = firebaseAuth.currentUser;

        if (user != null) {
          // var token = await user.getIdToken(true);
          // const storage = FlutterSecureStorage();
          // storage.write(
          //   key: StoredDataType.authToken.name,
          //   value: token,
          // );

          Reference ref = firebaseStorage
              .ref()
              .child(FirebaseIds.profilePics.name)
              .child(user.uid);

          var profilePhotoUrl = await ref.getDownloadURL();

          var singinUser = UserState(
              name: user.displayName ?? '',
              profilePhoto: profilePhotoUrl,
              email: email,
              uid: user.uid);

          _ref.watch(userProvider.notifier).update((state) => singinUser);

          _ref.refresh(routerProvider);
        } else {
          return "No user match with the email and the password";
        }
      } else {
        return "Fill in all fields";
      }
    } catch (e) {
      return e.toString();
    }

    return "";
  }

  void signout() async {
    await firebaseAuth.signOut();

    // const storage = FlutterSecureStorage();
    // storage.delete(key: StoredDataType.authToken.name);

    _ref.watch(userProvider.notifier).update(
          (state) => UserState(
            name: "",
            profilePhoto: "",
            email: "",
            uid: "",
          ),
        );
  }

  SnackBar getSnackBar(String text) {
    return SnackBar(
      content: Text(text),
    );
  }
}
