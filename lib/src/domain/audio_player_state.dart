import 'package:freezed_annotation/freezed_annotation.dart';
import 'audio_service.dart';

part 'audio_player_state.freezed.dart';

@freezed
abstract class AudioPlayerState with _$AudioPlayerState {
  const factory AudioPlayerState({
    @Default(PlayerState.stopped) PlayerState playerState,
    String? playingFilePath,
    String? currentDictationId, // New field
    int? currentRecordingIndex, // New field
    @Default(false) bool isSequentialPlaying, // New field
  }) = _AudioPlayerState;
}
