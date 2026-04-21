import 'recording.dart';

abstract class AudioService {
  Future<void> startRecording(String filePath);
  Future<Recording> stopRecording();
  Future<void> playRecording(String filePath);
  Future<void> pausePlayback();
  Future<void> stopPlayback();
  Future<void> setFilePath(String filePath);
  Future<void> deleteAudioFile(String filePath);
  Future<String> getRecordingFilePath();
  Future<bool> hasRecordingPermission();
  Future<bool> requestRecordingPermission();
  Stream<Duration?> get playbackPositionStream; // For current playback position
  Stream<PlayerState>
  get playerStateStream; // For player state changes (playing, paused, stopped)
  Stream<Duration?>
  get durationStream; // For total duration of the current playing audio
}

enum PlayerState {
  playing,
  paused,
  stopped,
  completed,
  // Add other states as needed, e.g., buffering, completed
}
