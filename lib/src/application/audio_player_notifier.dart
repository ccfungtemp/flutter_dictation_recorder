import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer; // Import for logging

import '../domain/audio_player_state.dart';
import '../domain/audio_service.dart';

import 'providers.dart';

class AudioPlayerNotifier extends Notifier<AudioPlayerState> {
  late AudioService _audioService;

  @override
  AudioPlayerState build() {
    _audioService = ref.watch(audioServiceProvider);

    _audioService.playerStateStream.listen((playerState) async {
      developer.log('AudioPlayerNotifier: PlayerState changed to $playerState');
      try {
        // Handle playback completion
        if (playerState == PlayerState.completed) {
          developer.log('AudioPlayerNotifier: Detected PlayerState.completed');
          // If there's a current dictation and recording, try to play the next one
          if (state.currentDictationId != null &&
              state.currentRecordingIndex != null &&
              state.isSequentialPlaying) {
            final dictations = ref
                .read(dictationsNotifierProvider)
                .value; // Get all dictations
            
            if (dictations == null || dictations.isEmpty) {
              developer.log('AudioPlayerNotifier: No dictations available');
              state = state.copyWith(
                playerState: PlayerState.stopped,
                playingFilePath: null,
                currentDictationId: null,
                currentRecordingIndex: null,
                isSequentialPlaying: false,
              );
              return;
            }
            
            final currentDictation = dictations.firstWhereOrNull(
              (d) => d.id == state.currentDictationId,
            );

            if (currentDictation != null) {
              final nextIndex = state.currentRecordingIndex! + 1;
              developer.log(
                'AudioPlayerNotifier: Attempting to play next recording. Current Index: ${state.currentRecordingIndex}, Next Index: $nextIndex, Total Recordings: ${currentDictation.recordings.length}',
              );
              if (nextIndex < currentDictation.recordings.length) {
                await _playRecording(
                  currentDictation.id,
                  nextIndex,
                  currentDictation.recordings[nextIndex].filePath,
                );
              } else {
                // All recordings for this dictation have been played
                developer.log(
                  'AudioPlayerNotifier: All recordings played. Stopping.',
                );
                state = state.copyWith(
                  playerState: PlayerState.stopped,
                  playingFilePath: null,
                  currentDictationId: null,
                  currentRecordingIndex: null,
                  isSequentialPlaying: false,
                );
              }
            } else {
              developer.log('AudioPlayerNotifier: Current dictation not found');
              state = state.copyWith(
                playerState: PlayerState.stopped,
                playingFilePath: null,
                currentDictationId: null,
                currentRecordingIndex: null,
                isSequentialPlaying: false,
              );
            }
          } else if (playerState == PlayerState.completed && !state.isSequentialPlaying) {
            // Single recording completed, stop
            state = state.copyWith(
              playerState: PlayerState.stopped,
              playingFilePath: null,
              currentDictationId: null,
              currentRecordingIndex: null,
            );
          }
        } else if (playerState == PlayerState.stopped) {
          developer.log('AudioPlayerNotifier: Detected PlayerState.stopped');
          state = state.copyWith(
            playerState: playerState,
            playingFilePath: null,
            currentDictationId: null,
            currentRecordingIndex: null,
          );
        } else {
          developer.log(
            'AudioPlayerNotifier: Detected PlayerState.playing/paused. Current state: $state',
          );
          state = state.copyWith(playerState: playerState);
        }
      } catch (e, stackTrace) {
        developer.log('AudioPlayerNotifier: Error in playerStateStream listener: $e\n$stackTrace');
        state = state.copyWith(
          playerState: PlayerState.stopped,
          playingFilePath: null,
          currentDictationId: null,
          currentRecordingIndex: null,
          isSequentialPlaying: false,
        );
      }
    });

    return const AudioPlayerState();
  }

  Future<void> _playRecording(
    String dictationId,
    int recordingIndex,
    String filePath,
  ) async {
    try {
      developer.log(
        'AudioPlayerNotifier: _playRecording called for Dictation ID: $dictationId, Index: $recordingIndex, File: $filePath',
      );
      // Stop any currently playing audio
      if (state.playingFilePath != null && state.playingFilePath != filePath) {
        await _audioService.stopPlayback();
      }

      state = state.copyWith(
        playingFilePath: filePath,
        currentDictationId: dictationId,
        currentRecordingIndex: recordingIndex,
        playerState: PlayerState.playing,
      );
      await _audioService.playRecording(filePath);
    } catch (e, stackTrace) {
      developer.log('AudioPlayerNotifier: Error in _playRecording: $e\n$stackTrace');
      // 播放失敗時停止並重置狀態
      state = state.copyWith(
        playerState: PlayerState.stopped,
        playingFilePath: null,
        currentDictationId: null,
        currentRecordingIndex: null,
        isSequentialPlaying: false,
      );
      rethrow; // 重新拋出異常讓上層處理
    }
  }

  Future<void> playAllRecordings(
    String dictationId, {
    int startIndex = 0,
  }) async {
    try {
      developer.log(
        'AudioPlayerNotifier: playAllRecordings called for Dictation ID: $dictationId, Start Index: $startIndex',
      );
      final dictations = ref
          .read(dictationsNotifierProvider)
          .value; // Get all dictations
      
      if (dictations == null || dictations.isEmpty) {
        throw Exception('No dictations available');
      }
      
      final dictation = dictations.firstWhereOrNull((d) => d.id == dictationId);

      if (dictation != null && dictation.recordings.isNotEmpty) {
        if (startIndex < dictation.recordings.length) {
          state = state.copyWith(isSequentialPlaying: true);
          await _playRecording(
            dictationId,
            startIndex,
            dictation.recordings[startIndex].filePath,
          );
        }
      } else {
        throw Exception('Dictation not found or has no recordings');
      }
    } catch (e, stackTrace) {
      developer.log('AudioPlayerNotifier: Error in playAllRecordings: $e\n$stackTrace');
      state = state.copyWith(
        playerState: PlayerState.stopped,
        playingFilePath: null,
        currentDictationId: null,
        currentRecordingIndex: null,
        isSequentialPlaying: false,
      );
      rethrow;
    }
  }

  /// 播放單個錄音，不進入順序播放模式
  Future<void> playSingleRecording(
    String dictationId,
    int recordingIndex,
  ) async {
    developer.log(
      'AudioPlayerNotifier: playSingleRecording called for Dictation ID: $dictationId, Index: $recordingIndex',
    );
    final dictations = ref
        .read(dictationsNotifierProvider)
        .value; // Get all dictations
    final dictation = dictations?.firstWhereOrNull((d) => d.id == dictationId);

    if (dictation != null && 
        recordingIndex >= 0 && 
        recordingIndex < dictation.recordings.length) {
      state = state.copyWith(isSequentialPlaying: false);
      await _playRecording(
        dictationId,
        recordingIndex,
        dictation.recordings[recordingIndex].filePath,
      );
    }
  }

  Future<void> playNext() async {
    developer.log(
      'AudioPlayerNotifier: playNext called. Current state: $state',
    );
    if (state.currentDictationId == null ||
        state.currentRecordingIndex == null) {
      return;
    }

    final dictations = ref.read(dictationsNotifierProvider).value;
    final currentDictation = dictations?.firstWhereOrNull(
      (d) => d.id == state.currentDictationId,
    );

    if (currentDictation != null) {
      final nextIndex = state.currentRecordingIndex! + 1;
      if (nextIndex < currentDictation.recordings.length) {
        await _playRecording(
          currentDictation.id,
          nextIndex,
          currentDictation.recordings[nextIndex].filePath,
        );
      } else {
        // Reached end of recordings, stop playback
        developer.log(
          'AudioPlayerNotifier: playNext reached end of recordings. Stopping.',
        );
        await stop();
      }
    }
  }

  Future<void> playPrevious() async {
    developer.log(
      'AudioPlayerNotifier: playPrevious called. Current state: $state',
    );
    if (state.currentDictationId == null ||
        state.currentRecordingIndex == null) {
      return;
    }

    final dictations = ref.read(dictationsNotifierProvider).value;
    final currentDictation = dictations?.firstWhereOrNull(
      (d) => d.id == state.currentDictationId,
    );

    if (currentDictation != null) {
      final previousIndex = state.currentRecordingIndex! - 1;
      if (previousIndex >= 0) {
        await _playRecording(
          currentDictation.id,
          previousIndex,
          currentDictation.recordings[previousIndex].filePath,
        );
      } else {
        // Reached beginning of recordings, stay on first or stop
        developer.log(
          'AudioPlayerNotifier: playPrevious reached beginning of recordings. Stopping.',
        );
        await stop(); // Or stay on the first recording
      }
    }
  }

  Future<void> pause() async {
    developer.log('AudioPlayerNotifier: pause called. Current state: $state');
    await _audioService.pausePlayback();
    // 暫停時不改變isSequentialPlaying，這樣resume時才能繼續順序播放
    state = state.copyWith(playerState: PlayerState.paused);
  }

  Future<void> resume() async {
    developer.log('AudioPlayerNotifier: resume called. Current state: $state');
    // If paused, just resume current playback
    if (state.playerState == PlayerState.paused &&
        state.playingFilePath != null) {
      await _audioService.playRecording(state.playingFilePath!);
      // 恢復時保留isSequentialPlaying的值
      state = state.copyWith(playerState: PlayerState.playing);
    } else if (state.playerState == PlayerState.stopped &&
        state.currentDictationId != null &&
        state.isSequentialPlaying) {
      // If stopped but in sequential mode, restart from current index
      developer.log(
        'AudioPlayerNotifier: resume from stopped state with sequential mode. Starting from index ${state.currentRecordingIndex ?? 0}',
      );
      await playAllRecordings(
        state.currentDictationId!,
        startIndex: state.currentRecordingIndex ?? 0,
      );
    }
  }

  Future<void> stop() async {
    developer.log('AudioPlayerNotifier: stop called. Current state: $state');
    await _audioService.stopPlayback();
    state = state.copyWith(
      playerState: PlayerState.stopped,
      playingFilePath: null,
      currentDictationId: null,
      currentRecordingIndex: null,
      isSequentialPlaying: false,
    );
  }

  // New method to set the current recording without starting playback
  Future<void> setCurrentRecording(
    String dictationId,
    int recordingIndex,
  ) async {
    developer.log(
      'AudioPlayerNotifier: setCurrentRecording called for Dictation ID: $dictationId, Index: $recordingIndex. Current state: $state',
    );
    final dictations = ref.read(dictationsNotifierProvider).value;
    final dictation = dictations?.firstWhereOrNull((d) => d.id == dictationId);

    if (dictation != null && dictation.recordings.isNotEmpty) {
      if (recordingIndex >= 0 && recordingIndex < dictation.recordings.length) {
        state = state.copyWith(
          playingFilePath: dictation.recordings[recordingIndex].filePath,
          currentDictationId: dictationId,
          currentRecordingIndex: recordingIndex,
          playerState:
              PlayerState.stopped, // Set to stopped as it's not playing
        );
        // Preload the audio file to allow for quick playback if user presses play
        await _audioService.setFilePath(
          dictation.recordings[recordingIndex].filePath,
        );
        developer.log(
          'AudioPlayerNotifier: setCurrentRecording updated state: $state',
        );
      }
    }
  }
}
