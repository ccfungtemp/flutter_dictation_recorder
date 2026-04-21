import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/recording.dart';
import '../domain/recording_state.dart';
import 'providers.dart';

class RecordingNotifier extends Notifier<RecordingState> {
  Timer? _timer;

  @override
  RecordingState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return const RecordingState();
  }

  Future<void> startRecording() async {
    final audioService = ref.read(audioServiceProvider);
    try {
      // Check if permission is already granted
      var hasPermission = await audioService.hasRecordingPermission();
      
      // If not granted, request permission
      if (!hasPermission) {
        hasPermission = await audioService.requestRecordingPermission();
      }
      
      // If still no permission, throw error
      if (!hasPermission) {
        state = state.copyWith(
          error: Exception('錄音權限未被授予'),
          isRecording: false,
        );
        return;
      }

      final path = await audioService.getRecordingFilePath();
      
      // Start recording
      await audioService.startRecording(path);

      // Update state immediately to show recording UI
      state = state.copyWith(
        isRecording: true,
        duration: Duration.zero,
        recordingPath: path,
        error: null,
      );

      // Start timer to update duration
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        state = state.copyWith(
          duration: state.duration + const Duration(milliseconds: 100),
        );
      });
    } catch (e) {
      state = state.copyWith(
        error: e is Exception ? e : Exception(e.toString()),
        isRecording: false,
      );
    }
  }

  Future<Recording?> stopRecording() async {
    final audioService = ref.read(audioServiceProvider);
    try {
      _timer?.cancel();
      final recording = await audioService.stopRecording();
      state = state.copyWith(
        isRecording: false,
        recordingPath: recording.filePath,
        duration: Duration.zero,
        error: null,
      );
      return recording;
    } catch (e) {
      state = state.copyWith(
        isRecording: false,
        duration: Duration.zero,
        error: e is Exception ? e : Exception(e.toString()),
      );
      return null;
    }
  }
}
