import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone_flutter/constants.dart';
import 'package:tiktok_clone_flutter/providers/provider.dart';
import 'package:tiktok_clone_flutter/view_models/comment_view_model.dart';
import 'package:tiktok_clone_flutter/view_models/home_view_model.dart';
import 'package:tiktok_clone_flutter/view_models/profile_view_model.dart';
import 'package:tiktok_clone_flutter/view_models/signin_view_model.dart';
import 'package:tiktok_clone_flutter/view_models/signup_view_model.dart';
import 'package:tiktok_clone_flutter/views/add_video_view.dart';
import 'package:tiktok_clone_flutter/views/comment_view.dart';
import 'package:tiktok_clone_flutter/views/confirm_screen.dart';
import 'package:tiktok_clone_flutter/views/error_view.dart';
import 'package:tiktok_clone_flutter/views/home_view.dart';
import 'package:tiktok_clone_flutter/views/profile_view.dart';
import 'package:tiktok_clone_flutter/views/signin_view.dart';
import 'package:tiktok_clone_flutter/views/signup_view.dart';

// Reference : https://zenn.dev/kingu/scraps/5216f812efc4e7
final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: '/',
    // urlPathStrategy: UrlPathStrategy.path,
    redirect: (state) {
      final isSignedIn = firebaseAuth.currentUser != null;
      final goingToSignIn = state.subloc == '/signin';
      final goingToSignUp = state.subloc == '/signup';

      final params = Uri.parse(state.location).queryParameters;
      final from = params['from'] ?? '';

      if (goingToSignUp) {
        return null;
      }

      if (!isSignedIn && !goingToSignIn) {
        return '/signin?from=${state.location}';
      }

      if (isSignedIn && goingToSignIn) {
        return from.isNotEmpty ? from : '/';
      }

      return null;
    },
    errorBuilder: (context, state) => const ErrorView(),
    routes: [
      GoRoute(
        path: '/',
        name: 'Home',
        builder: (context, state) => HomeView(
          HomeViewModel(),
        ),
        routes: [
          GoRoute(
            path: 'upload',
            name: 'upload',
            builder: (context, state) => ConfirmView(
              videoPath: state.queryParams['videoPath'] ?? '',
            ),
          ),
          GoRoute(
            path: 'comment',
            name: 'comment',
            builder: (context, state) => CommentView(
              CommentViewModel(),
              id: state.queryParams['id'] ?? '',
            ),
          ),
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) => ProfileView(
              ProfileViewModel(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/signin',
        name: 'Signin',
        builder: (context, state) => SigninView(
          SigninViewModel(state.queryParams['from'] ?? ''),
        ),
      ),
      GoRoute(
        path: '/signup',
        name: 'Signup',
        builder: (context, state) => SignupView(SignupViewModel()),
      ),
    ],
  ),
);
