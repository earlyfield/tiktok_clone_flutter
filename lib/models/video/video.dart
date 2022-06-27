import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class Video with _$Video {
  factory Video({
    required String username,
    required String uid,
    required String id,
    required List likes,
    required int commentCount,
    required int shareCount,
    required String songName,
    required String caption,
    required String videoUrl,
    required String thumbnail,
    required String profilePhoto,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  static Video empty() {
    return Video(
      username: "",
      uid: "",
      id: "",
      likes: [],
      commentCount: 0,
      shareCount: 0,
      songName: "",
      caption: "",
      videoUrl: "",
      thumbnail: "",
      profilePhoto: "",
    );
  }
}
