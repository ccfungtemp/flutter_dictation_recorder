import 'dictation.dart';

abstract class DataRepository {
  Future<List<Dictation>> loadAllDictations();
  Future<void> saveDictation(Dictation dictation);
  Future<void> deleteDictation(String dictationId);
  Future<void> updateDictation(Dictation dictation);
}
