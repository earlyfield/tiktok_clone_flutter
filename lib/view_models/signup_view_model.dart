import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone_flutter/constants.dart';
import 'package:tiktok_clone_flutter/models/snackbar_state/snackbar_state.dart';
import 'package:tiktok_clone_flutter/models/user_state/user_state.dart';
import 'package:tiktok_clone_flutter/providers/provider.dart';
import 'package:tiktok_clone_flutter/providers/routerProvider.dart';

class SignupViewModel {
  late WidgetRef _ref;

  UserState get user => _ref.watch(userProvider);

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _ref.watch(snackBarStateProvider.notifier).update(
            (state) => SnackBarState(
              showSnackBar: true,
              message:
                  "Profile Picture¥r¥nYou have successfully selected your profile picture!",
            ),
          );
    }

    _ref.watch(pickedImageProvider.notifier).update((state) => pickedImage);
  }

  Future<String> registerUser(
    String username,
    String email,
    String password,
    XFile? image,
  ) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String downloadUrl = await _uploadToStorage(image);

        UserState user = UserState(
          name: username,
          profilePhoto: downloadUrl,
          email: email,
          uid: cred.user!.uid,
        );

        await firestore
            .collection(FirebaseIds.users.name)
            .doc(cred.user!.uid)
            .set(user.toJson());

        _ref.watch(userProvider.notifier).update((state) => user);

        // _ref.watch(routerProvider).go("/");
        _ref.refresh(routerProvider);

        return "Succeeded to sing up";
      } else {
        // _ref.watch(snackBarStateProvider.notifier).update(
        //       (state) => SnackBarState(
        //         showSnackBar: true,
        //         message:
        //             "Error Creating Account¥r¥nPlease enter all the fields",
        //       ),
        //     );
        return "Error Creating Account¥r¥nPlease enter all the fields";
      }
    } catch (e) {
      print(e.toString());
      // _ref.watch(snackBarStateProvider.notifier).update(
      //       (state) => SnackBarState(
      //         showSnackBar: true,
      //         message: e.toString(),
      //       ),
      //     );

      return e.toString();
    }
  }

  Future<String> _uploadToStorage(XFile image) async {
    Reference ref = firebaseStorage
        .ref()
        .child(FirebaseIds.profilePics.name)
        .child(firebaseAuth.currentUser!.uid);

    final fileBytes = await image.readAsBytes();

    UploadTask uploadTask = ref.putData(fileBytes);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
