import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/json_data_repository.dart';
import '../data/record_audio_service.dart';
import '../domain/audio_service.dart';
import '../domain/data_repository.dart';
import '../domain/dictation.dart';
import '../domain/settings.dart';
import '../domain/recording_state.dart';
import '../domain/audio_player_state.dart';
import 'audio_player_notifier.dart';
import 'dictations_notifier.dart';
import 'settings_provider.dart';
import 'recording_notifier.dart';

final dataRepositoryProvider = Provider<DataRepository>((ref) {
  return JsonDataRepository();
});

final audioServiceProvider = Provider<AudioService>((ref) {
  return RecordAudioService();
});

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return SharedPreferences.getInstance();
});

final dictationsNotifierProvider =
    AsyncNotifierProvider<DictationsNotifier, List<Dictation>>(
      DictationsNotifier.new,
    );

final audioPlayerNotifierProvider =
    NotifierProvider<AudioPlayerNotifier, AudioPlayerState>(
      AudioPlayerNotifier.new,
    );

final settingsNotifierProvider =
    AsyncNotifierProvider<SettingsNotifier, Settings>(SettingsNotifier.new);

final recordingNotifierProvider =
    NotifierProvider<RecordingNotifier, RecordingState>(RecordingNotifier.new);
