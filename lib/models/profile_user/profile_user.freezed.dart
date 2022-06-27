// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'profile_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProfileUser _$ProfileUserFromJson(Map<String, dynamic> json) {
  return _ProfileUser.fromJson(json);
}

/// @nodoc
mixin _$ProfileUser {
  String get name => throw _privateConstructorUsedError;
  String get profilePhoto => throw _privateConstructorUsedError;
  List<String> get thumbnails => throw _privateConstructorUsedError;
  String get likes => throw _privateConstructorUsedError;
  String get followers => throw _privateConstructorUsedError;
  String get following => throw _privateConstructorUsedError;
  bool get isFollowing => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileUserCopyWith<ProfileUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileUserCopyWith<$Res> {
  factory $ProfileUserCopyWith(
          ProfileUser value, $Res Function(ProfileUser) then) =
      _$ProfileUserCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String profilePhoto,
      List<String> thumbnails,
      String likes,
      String followers,
      String following,
      bool isFollowing});
}

/// @nodoc
class _$ProfileUserCopyWithImpl<$Res> implements $ProfileUserCopyWith<$Res> {
  _$ProfileUserCopyWithImpl(this._value, this._then);

  final ProfileUser _value;
  // ignore: unused_field
  final $Res Function(ProfileUser) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? profilePhoto = freezed,
    Object? thumbnails = freezed,
    Object? likes = freezed,
    Object? followers = freezed,
    Object? following = freezed,
    Object? isFollowing = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profilePhoto: profilePhoto == freezed
          ? _value.profilePhoto
          : profilePhoto // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnails: thumbnails == freezed
          ? _value.thumbnails
          : thumbnails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likes: likes == freezed
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as String,
      followers: followers == freezed
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as String,
      following: following == freezed
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as String,
      isFollowing: isFollowing == freezed
          ? _value.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_ProfileUserCopyWith<$Res>
    implements $ProfileUserCopyWith<$Res> {
  factory _$$_ProfileUserCopyWith(
          _$_ProfileUser value, $Res Function(_$_ProfileUser) then) =
      __$$_ProfileUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String profilePhoto,
      List<String> thumbnails,
      String likes,
      String followers,
      String following,
      bool isFollowing});
}

/// @nodoc
class __$$_ProfileUserCopyWithImpl<$Res> extends _$ProfileUserCopyWithImpl<$Res>
    implements _$$_ProfileUserCopyWith<$Res> {
  __$$_ProfileUserCopyWithImpl(
      _$_ProfileUser _value, $Res Function(_$_ProfileUser) _then)
      : super(_value, (v) => _then(v as _$_ProfileUser));

  @override
  _$_ProfileUser get _value => super._value as _$_ProfileUser;

  @override
  $Res call({
    Object? name = freezed,
    Object? profilePhoto = freezed,
    Object? thumbnails = freezed,
    Object? likes = freezed,
    Object? followers = freezed,
    Object? following = freezed,
    Object? isFollowing = freezed,
  }) {
    return _then(_$_ProfileUser(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profilePhoto: profilePhoto == freezed
          ? _value.profilePhoto
          : profilePhoto // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnails: thumbnails == freezed
          ? _value._thumbnails
          : thumbnails // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likes: likes == freezed
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as String,
      followers: followers == freezed
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as String,
      following: following == freezed
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as String,
      isFollowing: isFollowing == freezed
          ? _value.isFollowing
          : isFollowing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProfileUser implements _ProfileUser {
  _$_ProfileUser(
      {required this.name,
      required this.profilePhoto,
      required final List<String> thumbnails,
      required this.likes,
      required this.followers,
      required this.following,
      required this.isFollowing})
      : _thumbnails = thumbnails;

  factory _$_ProfileUser.fromJson(Map<String, dynamic> json) =>
      _$$_ProfileUserFromJson(json);

  @override
  final String name;
  @override
  final String profilePhoto;
  final List<String> _thumbnails;
  @override
  List<String> get thumbnails {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_thumbnails);
  }

  @override
  final String likes;
  @override
  final String followers;
  @override
  final String following;
  @override
  final bool isFollowing;

  @override
  String toString() {
    return 'ProfileUser(name: $name, profilePhoto: $profilePhoto, thumbnails: $thumbnails, likes: $likes, followers: $followers, following: $following, isFollowing: $isFollowing)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProfileUser &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.profilePhoto, profilePhoto) &&
            const DeepCollectionEquality()
                .equals(other._thumbnails, _thumbnails) &&
            const DeepCollectionEquality().equals(other.likes, likes) &&
            const DeepCollectionEquality().equals(other.followers, followers) &&
            const DeepCollectionEquality().equals(other.following, following) &&
            const DeepCollectionEquality()
                .equals(other.isFollowing, isFollowing));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(profilePhoto),
      const DeepCollectionEquality().hash(_thumbnails),
      const DeepCollectionEquality().hash(likes),
      const DeepCollectionEquality().hash(followers),
      const DeepCollectionEquality().hash(following),
      const DeepCollectionEquality().hash(isFollowing));

  @JsonKey(ignore: true)
  @override
  _$$_ProfileUserCopyWith<_$_ProfileUser> get copyWith =>
      __$$_ProfileUserCopyWithImpl<_$_ProfileUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProfileUserToJson(this);
  }
}

abstract class _ProfileUser implements ProfileUser {
  factory _ProfileUser(
      {required final String name,
      required final String profilePhoto,
      required final List<String> thumbnails,
      required final String likes,
      required final String followers,
      required final String following,
      required final bool isFollowing}) = _$_ProfileUser;

  factory _ProfileUser.fromJson(Map<String, dynamic> json) =
      _$_ProfileUser.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get profilePhoto => throw _privateConstructorUsedError;
  @override
  List<String> get thumbnails => throw _privateConstructorUsedError;
  @override
  String get likes => throw _privateConstructorUsedError;
  @override
  String get followers => throw _privateConstructorUsedError;
  @override
  String get following => throw _privateConstructorUsedError;
  @override
  bool get isFollowing => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ProfileUserCopyWith<_$_ProfileUser> get copyWith =>
      throw _privateConstructorUsedError;
}
