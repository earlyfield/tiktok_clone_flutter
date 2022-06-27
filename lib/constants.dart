import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone_flutter/models/snackbar_state/snackbar_state.dart';
import 'package:tiktok_clone_flutter/models/user_state/user_state.dart';
import 'package:tiktok_clone_flutter/providers/provider.dart';
import 'package:tiktok_clone_flutter/view_models/profile_view_model.dart';
import 'package:tiktok_clone_flutter/view_models/video_view_model.dart';
import 'package:tiktok_clone_flutter/views/add_video_view.dart';
import 'package:tiktok_clone_flutter/views/messages_view.dart';
import 'package:tiktok_clone_flutter/views/profile_view.dart';
import 'package:tiktok_clone_flutter/views/search_view.dart';
import 'package:tiktok_clone_flutter/views/video_view.dart';

List pages = [
  VideoView(VideoViewModel()),
  const SearchView(),
  AddVideoView(),
  MessagesView(),
  ProfileView(
    ProfileViewModel(),
  ),
];

enum PageType {
  video,
  search,
  addVideo,
  messages,
  profile,
}

extension PageNameExt on PageType {
  int get num {
    switch (this) {
      case PageType.video:
        return 0;
      case PageType.search:
        return 1;
      case PageType.addVideo:
        return 2;
      case PageType.messages:
        return 3;
      case PageType.profile:
        return 4;
    }
  }
}

enum StoredDataType {
  authToken,
}

extension StoredDataTypeExt on StoredDataType {
  String get name {
    switch (this) {
      case StoredDataType.authToken:
        return 'authToken';
    }
  }
}

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

enum FirebaseIds {
  profilePics,
  users,
  videos,
  comments,
}

extension FirebaseIdsExt on FirebaseIds {
  String get name {
    switch (this) {
      case FirebaseIds.profilePics:
        return "profilePics";
      case FirebaseIds.users:
        return "users";
      case FirebaseIds.videos:
        return "videos";
      case FirebaseIds.comments:
        return "comments";
    }
  }
}

// Common functions

void showSnackBar(BuildContext context, WidgetRef ref) {
  ref.listen<SnackBarState>(snackBarStateProvider, (prev, next) {
    // if (prev?.showSnackBar != next.showSnackBar) {
    if (next.showSnackBar) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(next.message)),
      );
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
    // }
  });
}

Image makeImage(XFile? file, String path) {
  if (file == null) {
    return Image.asset(path);
  } else {
    if (kIsWeb) {
      return Image.network(file.path);
    }

    return Image.file(File(file.path));
  }
}

void storeData<T>(String type, T data) async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  var jsonString = jsonEncode(data);
  shared.setString(type, jsonString);
}

Future<T?> getStoredData<T>(
    String type, T Function(Map<String, dynamic>) callback) async {
  SharedPreferences shared = await SharedPreferences.getInstance();
  var jsonString = shared.getString(type);

  if (jsonString != null) {
    var map = jsonDecode(jsonString);
    return callback(map);
  }

  return null;
}
