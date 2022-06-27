// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProfileUser _$$_ProfileUserFromJson(Map<String, dynamic> json) =>
    _$_ProfileUser(
      name: json['name'] as String,
      profilePhoto: json['profilePhoto'] as String,
      thumbnails: (json['thumbnails'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      likes: json['likes'] as String,
      followers: json['followers'] as String,
      following: json['following'] as String,
      isFollowing: json['isFollowing'] as bool,
    );

Map<String, dynamic> _$$_ProfileUserToJson(_$_ProfileUser instance) =>
    <String, dynamic>{
      'name': instance.name,
      'profilePhoto': instance.profilePhoto,
      'thumbnails': instance.thumbnails,
      'likes': instance.likes,
      'followers': instance.followers,
      'following': instance.following,
      'isFollowing': instance.isFollowing,
    };
