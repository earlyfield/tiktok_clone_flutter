import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';
part 'user_state.g.dart';

@freezed
class UserState with _$UserState {
  factory UserState({
    required String name,
    required String profilePhoto,
    required String email,
    required String uid,
  }) = _UserState;

  UserState._();

  factory UserState.fromJson(Map<String, dynamic> json) =>
      _$UserStateFromJson(json);

  late final bool isSignedIn = uid != "";
}
