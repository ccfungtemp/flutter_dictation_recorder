import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/settings.dart';
import 'providers.dart';

class SettingsNotifier extends AsyncNotifier<Settings> {
  static const String _settingsKey = 'settings';

  Future<Settings> _loadSettings() async {
    final prefs = await ref.watch(sharedPreferencesProvider.future);
    final settingsString = prefs.getString(_settingsKey);
    if (settingsString != null) {
      return Settings.fromJson(json.decode(settingsString));
    }
    return const Settings(); // Default settings
  }

  @override
  Future<Settings> build() async {
    return _loadSettings();
  }

  Future<void> updateSettings(Settings newSettings) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    await prefs.setString(_settingsKey, json.encode(newSettings.toJson()));
    state = AsyncData(newSettings);
  }

  Future<void> setPauseDuration(int seconds) async {
    final currentSettings = await future;
    final newSettings = currentSettings.copyWith(pauseDurationSeconds: seconds);
    await updateSettings(newSettings);
  }
}
