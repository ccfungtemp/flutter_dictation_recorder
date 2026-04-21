import 'package:freezed_annotation/freezed_annotation.dart';

part 'recording_state.freezed.dart';

@freezed
abstract class RecordingState with _$RecordingState {
  const factory RecordingState({
    @Default(false) bool isRecording,
    @Default(Duration.zero) Duration duration,
    String? recordingPath,
    Exception? error,
  }) = _RecordingState;
}
