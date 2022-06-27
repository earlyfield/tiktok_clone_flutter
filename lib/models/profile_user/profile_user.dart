import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_user.freezed.dart';
part 'profile_user.g.dart';

@freezed
class ProfileUser with _$ProfileUser {
  factory ProfileUser({
    required String name,
    required String profilePhoto,
    required List<String> thumbnails,
    required String likes,
    required String followers,
    required String following,
    required bool isFollowing,
  }) = _ProfileUser;

  factory ProfileUser.fromJson(Map<String, dynamic> json) =>
      _$ProfileUserFromJson(json);
}
