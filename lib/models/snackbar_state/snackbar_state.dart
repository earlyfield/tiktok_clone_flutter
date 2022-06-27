import 'package:freezed_annotation/freezed_annotation.dart';

part 'snackbar_state.freezed.dart';
part 'snackbar_state.g.dart';

@freezed
class SnackBarState with _$SnackBarState {
  factory SnackBarState({
    required bool showSnackBar,
    required String message,
  }) = _SnackBarState;

  factory SnackBarState.fromJson(Map<String, dynamic> json) =>
      _$SnackBarStateFromJson(json);
}
