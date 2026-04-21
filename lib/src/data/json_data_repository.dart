import 'dart:convert';
import 'dart:io';

import '../domain/data_repository.dart';
import '../domain/dictation.dart';
import 'package:path_provider/path_provider.dart';

class JsonDataRepository implements DataRepository {
  static const String _fileName = 'dictations.json';

  // Injectable file factory for testing
  static File Function(String path) fileFactory = (path) => File(path);

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return fileFactory('${directory.path}/$_fileName'); // Use injected factory
  }

  @override
  Future<List<Dictation>> loadAllDictations() async {
    final file = await _getFile();
    if (!await file.exists()) {
      return [];
    }
    final content = await file.readAsString();
    final List<dynamic> jsonList = json.decode(content);
    return jsonList.map((json) => Dictation.fromJson(json)).toList();
  }

  @override
  Future<void> saveDictation(Dictation dictation) async {
    final List<Dictation> allDictations = await loadAllDictations();
    // Check if dictation already exists (update if it does, add if it doesn't)
    final existingIndex = allDictations.indexWhere((d) => d.id == dictation.id);
    if (existingIndex != -1) {
      allDictations[existingIndex] = dictation;
    } else {
      allDictations.add(dictation);
    }
    await _saveAll(allDictations);
  }

  @override
  Future<void> updateDictation(Dictation dictation) async {
    final List<Dictation> allDictations = await loadAllDictations();
    final existingIndex = allDictations.indexWhere((d) => d.id == dictation.id);
    if (existingIndex == -1) {
      throw Exception(
        'Dictation with ID ${dictation.id} not found for update.',
      );
    }
    allDictations[existingIndex] = dictation;
    await _saveAll(allDictations);
  }

  @override
  Future<void> deleteDictation(String dictationId) async {
    final List<Dictation> allDictations = await loadAllDictations();
    allDictations.removeWhere((d) => d.id == dictationId);
    await _saveAll(allDictations);
  }

  Future<void> _saveAll(List<Dictation> dictations) async {
    final file = await _getFile();
    final jsonList = dictations.map((d) => d.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }
}
