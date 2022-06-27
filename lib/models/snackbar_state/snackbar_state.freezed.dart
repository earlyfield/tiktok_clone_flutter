// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'snackbar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SnackBarState _$SnackBarStateFromJson(Map<String, dynamic> json) {
  return _SnackBarState.fromJson(json);
}

/// @nodoc
mixin _$SnackBarState {
  bool get showSnackBar => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SnackBarStateCopyWith<SnackBarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnackBarStateCopyWith<$Res> {
  factory $SnackBarStateCopyWith(
          SnackBarState value, $Res Function(SnackBarState) then) =
      _$SnackBarStateCopyWithImpl<$Res>;
  $Res call({bool showSnackBar, String message});
}

/// @nodoc
class _$SnackBarStateCopyWithImpl<$Res>
    implements $SnackBarStateCopyWith<$Res> {
  _$SnackBarStateCopyWithImpl(this._value, this._then);

  final SnackBarState _value;
  // ignore: unused_field
  final $Res Function(SnackBarState) _then;

  @override
  $Res call({
    Object? showSnackBar = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      showSnackBar: showSnackBar == freezed
          ? _value.showSnackBar
          : showSnackBar // ignore: cast_nullable_to_non_nullable
              as bool,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_SnackBarStateCopyWith<$Res>
    implements $SnackBarStateCopyWith<$Res> {
  factory _$$_SnackBarStateCopyWith(
          _$_SnackBarState value, $Res Function(_$_SnackBarState) then) =
      __$$_SnackBarStateCopyWithImpl<$Res>;
  @override
  $Res call({bool showSnackBar, String message});
}

/// @nodoc
class __$$_SnackBarStateCopyWithImpl<$Res>
    extends _$SnackBarStateCopyWithImpl<$Res>
    implements _$$_SnackBarStateCopyWith<$Res> {
  __$$_SnackBarStateCopyWithImpl(
      _$_SnackBarState _value, $Res Function(_$_SnackBarState) _then)
      : super(_value, (v) => _then(v as _$_SnackBarState));

  @override
  _$_SnackBarState get _value => super._value as _$_SnackBarState;

  @override
  $Res call({
    Object? showSnackBar = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_SnackBarState(
      showSnackBar: showSnackBar == freezed
          ? _value.showSnackBar
          : showSnackBar // ignore: cast_nullable_to_non_nullable
              as bool,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SnackBarState implements _SnackBarState {
  _$_SnackBarState({required this.showSnackBar, required this.message});

  factory _$_SnackBarState.fromJson(Map<String, dynamic> json) =>
      _$$_SnackBarStateFromJson(json);

  @override
  final bool showSnackBar;
  @override
  final String message;

  @override
  String toString() {
    return 'SnackBarState(showSnackBar: $showSnackBar, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SnackBarState &&
            const DeepCollectionEquality()
                .equals(other.showSnackBar, showSnackBar) &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(showSnackBar),
      const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$$_SnackBarStateCopyWith<_$_SnackBarState> get copyWith =>
      __$$_SnackBarStateCopyWithImpl<_$_SnackBarState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SnackBarStateToJson(this);
  }
}

abstract class _SnackBarState implements SnackBarState {
  factory _SnackBarState(
      {required final bool showSnackBar,
      required final String message}) = _$_SnackBarState;

  factory _SnackBarState.fromJson(Map<String, dynamic> json) =
      _$_SnackBarState.fromJson;

  @override
  bool get showSnackBar => throw _privateConstructorUsedError;
  @override
  String get message => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_SnackBarStateCopyWith<_$_SnackBarState> get copyWith =>
      throw _privateConstructorUsedError;
}
