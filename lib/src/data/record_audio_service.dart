import 'dart:async';
import 'dart:io';

import '../domain/audio_service.dart';
import '../domain/recording.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart'; // For generating unique IDs
import 'package:permission_handler/permission_handler.dart';

class RecordAudioService implements AudioService {
  RecordAudioService() {
    _audioPlayer.playerStateStream.listen((playerState) {
      // Convert just_audio's PlayerState to our custom PlayerState
      if (playerState.processingState == just_audio.ProcessingState.ready &&
          playerState.playing) {
        _playerStateController.add(PlayerState.playing);
      } else if (playerState.processingState ==
              just_audio.ProcessingState.ready &&
          !playerState.playing) {
        _playerStateController.add(PlayerState.paused);
      } else if (playerState.processingState ==
          just_audio.ProcessingState.completed) {
        _playerStateController.add(PlayerState.completed);
      } else if (playerState.processingState ==
          just_audio.ProcessingState.idle) {
        _playerStateController.add(PlayerState.stopped);
      }
    });
  }
  final AudioRecorder _audioRecorder = AudioRecorder();
  final just_audio.AudioPlayer _audioPlayer = just_audio.AudioPlayer();
  final Uuid _uuid = const Uuid();

  String? _currentRecordingPath;

  // Stream Controllers for exposing player state
  final StreamController<Duration?> _playbackPositionController =
      StreamController<Duration?>.broadcast();
  final StreamController<PlayerState> _playerStateController =
      StreamController<PlayerState>.broadcast();
  final StreamController<Duration?> _durationController =
      StreamController<Duration?>.broadcast();

  @override
  Stream<Duration?> get playbackPositionStream => _audioPlayer.positionStream;

  @override
  Stream<PlayerState> get playerStateStream => _playerStateController.stream;

  @override
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;

  @override
  Future<void> startRecording(String filePath) async {
    if (await _audioRecorder.hasPermission()) {
      _currentRecordingPath = filePath;
      await _audioRecorder.start(
        const RecordConfig(),
        path: _currentRecordingPath!,
      );
    } else {
      throw Exception('Recording permission not granted');
    }
  }

  @override
  Future<Recording> stopRecording() async {
    final path = await _audioRecorder.stop();
    if (path == null) {
      throw Exception('Failed to stop recording or retrieve file path.');
    }

    final duration = await _audioPlayer.setFilePath(
      path,
    ); // Get duration from just_audio
    await _audioPlayer.stop(); // Stop playback just after getting duration

    if (duration == null) {
      throw Exception('Could not get duration for recorded audio.');
    }

    return Recording(
      id: _uuid.v4(),
      filePath: path,
      durationSeconds: duration.inSeconds,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<void> playRecording(String filePath) async {
    try {
      await _audioPlayer.setFilePath(filePath);
      await _audioPlayer.play();
    } catch (e) {
      throw Exception('Error playing recording: $e');
    }
  }

  @override
  Future<void> pausePlayback() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> stopPlayback() async {
    await _audioPlayer.stop();
    _playerStateController.add(PlayerState.stopped); // Manually set to stopped
  }

  @override
  Future<void> setFilePath(String filePath) async {
    await _audioPlayer.setFilePath(filePath);
  }

  @override
  Future<void> deleteAudioFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  Future<bool> hasRecordingPermission() async {
    return await _audioRecorder.hasPermission();
  }

  @override
  Future<bool> requestRecordingPermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  @override
  Future<String> getRecordingFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final String uuid = _uuid.v4();
    return '${directory.path}/$uuid.m4a'; // Using m4a for good quality and small size
  }

  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    _playbackPositionController.close();
    _playerStateController.close();
    _durationController.close();
  }
}
