import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/dictation.dart';
import 'providers.dart';

class DictationsNotifier extends AsyncNotifier<List<Dictation>> {
  @override
  Future<List<Dictation>> build() {
    final dataRepository = ref.watch(dataRepositoryProvider);
    return dataRepository.loadAllDictations();
  }

  Future<void> addDictation(Dictation dictation) async {
    final dataRepository = ref.read(dataRepositoryProvider);
    await dataRepository.saveDictation(dictation);
    ref.invalidateSelf();
    await future; // Ensure the provider is fully refreshed
  }

  Future<void> updateDictation(Dictation dictation) async {
    final dataRepository = ref.read(dataRepositoryProvider);
    await dataRepository.updateDictation(dictation);
    ref.invalidateSelf();
    await future;
  }

  Future<void> deleteDictation(String dictationId) async {
    final dataRepository = ref.read(dataRepositoryProvider);
    await dataRepository.deleteDictation(dictationId);
    ref.invalidateSelf();
    await future;
  }
}
