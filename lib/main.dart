import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone_flutter/constants.dart';
import 'package:tiktok_clone_flutter/firebase_options.dart';
import 'package:tiktok_clone_flutter/models/user_state/user_state.dart';
import 'package:tiktok_clone_flutter/providers/lisnerable_providers.dart';
import 'package:tiktok_clone_flutter/providers/provider.dart';
import 'package:tiktok_clone_flutter/providers/routerProvider.dart';

void main() async {
  // URLに'#'を入らないようにする設定。
  // GoRouterのコンストラクタに入れることも可能だが、その場合はホットリスタートがエラーになる。
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  // Firebaseの初期設定
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      refreshListenableProvider,
      (previous, next) {
        ref.read(routerProvider).refresh();
      },
    );

    if (firebaseAuth.currentUser != null) {
      var user = firebaseAuth.currentUser!;

      Reference firebaseRef = firebaseStorage
          .ref()
          .child(FirebaseIds.profilePics.name)
          .child(user.uid);

      firebaseRef.getDownloadURL().then((url) {
        var singinUser = UserState(
          name: user.displayName ?? '',
          profilePhoto: url,
          email: user.email ?? "",
          uid: user.uid,
        );

        ref.watch(userProvider.notifier).update((state) => singinUser);
      });
    }

    // if (firebaseAuth.currentUser != null) {
    //   const storage = FlutterSecureStorage();
    //   storage.read(key: StoredDataType.authToken.name).then((token) {
    //     if (token != null) {
    //       firebaseAuth.signInWithCustomToken(token).then((cred) {
    //         var user = firebaseAuth.currentUser;

    //         if (user != null) {
    //           Reference firebaseRef = firebaseStorage
    //               .ref()
    //               .child(FirebaseIds.profilePics.name)
    //               .child(user.uid);

    //           firebaseRef.getDownloadURL().then((url) {
    //             var singinUser = UserState(
    //               name: user.displayName ?? '',
    //               profilePhoto: url,
    //               email: user.email ?? "",
    //               uid: user.uid,
    //             );

    //             ref.watch(userProvider.notifier).update((state) => singinUser);
    //           });
    //         }
    //       });
    //     }
    //   });
    // }

    return MaterialApp.router(
      routeInformationParser: ref.watch(routerProvider).routeInformationParser,
      routerDelegate: ref.watch(routerProvider).routerDelegate,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
    );
  }
}
