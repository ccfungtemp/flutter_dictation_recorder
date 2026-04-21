import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dictation_recorder/src/data/json_data_repository.dart';
import 'package:flutter_dictation_recorder/src/domain/dictation.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// A fake implementation of PathProviderPlatform for testing
class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  String? appDocumentsPath;

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return appDocumentsPath;
  }
}

// A simple in-memory file system for testing
Map<String, String> _inMemoryFileSystem = {};

class MockFile implements File {
  MockFile(this._path);
  final String _path;

  @override
  Future<bool> exists() async => _inMemoryFileSystem.containsKey(_path);

  @override
  bool existsSync() => _inMemoryFileSystem.containsKey(_path);

  @override
  Future<File> writeAsString(
    String contents, {
    FileMode mode = FileMode.write,
    Encoding encoding = utf8,
    bool flush = false,
  }) async {
    _inMemoryFileSystem[_path] = contents;
    return this;
  }

  @override
  String readAsStringSync({Encoding encoding = utf8}) {
    return _inMemoryFileSystem[_path] ?? '';
  }

  @override
  Future<String> readAsString({Encoding encoding = utf8}) async {
    return _inMemoryFileSystem[_path] ?? '';
  }

  @override
  Future<FileSystemEntity> delete({bool recursive = false}) async {
    _inMemoryFileSystem.remove(_path);
    return this;
  }

  @override
  String get path => _path;

  // Implement other File methods as needed for tests, or throw UnimplementedError
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('JsonDataRepository', () {
    late JsonDataRepository repository;
    late FakePathProviderPlatform fakePlatform;
    const String testDocPath = '/test/app/documents';
    const String testFilePath = '$testDocPath/dictations.json';

    setUp(() {
      _inMemoryFileSystem.clear(); // Clear the file system before each test
      fakePlatform = FakePathProviderPlatform()..appDocumentsPath = testDocPath;
      PathProviderPlatform.instance = fakePlatform;

      // Ensure that File operations use our mock
      // This is a global override and needs to be handled carefully in a real project
      // For this test, it's acceptable.
      JsonDataRepository.fileFactory = (path) => MockFile(path);

      repository = JsonDataRepository();
    });

    // Helper to get file content from our mock file system
    String getTestFileContent() => _inMemoryFileSystem[testFilePath] ?? '';

    test(
      'loadAllDictations returns empty list if file does not exist',
      () async {
        final dictations = await repository.loadAllDictations();
        expect(dictations, isEmpty);
      },
    );

    test('saveDictation adds a new dictation if it does not exist', () async {
      final dictation = Dictation(
        id: 'dict1',
        categoryName: 'Category A',
        textbookName: 'Textbook 1',
        recordings: [],
        createdAt: DateTime.utc(2026, 4, 10),
      );

      await repository.saveDictation(dictation);

      final loadedDictations = await repository.loadAllDictations();
      expect(loadedDictations.length, 1);
      expect(loadedDictations.first.id, 'dict1');
      expect(getTestFileContent(), contains('dict1'));
    });

    test('saveDictation updates an existing dictation', () async {
      final initialDictation = Dictation(
        id: 'dict1',
        categoryName: 'Category A',
        textbookName: 'Textbook 1',
        recordings: [],
        createdAt: DateTime.utc(2026, 4, 10),
      );
      await repository.saveDictation(initialDictation);

      final updatedDictation = initialDictation.copyWith(
        categoryName: 'Category B',
      );
      await repository.saveDictation(
        updatedDictation,
      ); // Calling save again acts as an update

      final loadedDictations = await repository.loadAllDictations();
      expect(loadedDictations.length, 1);
      expect(loadedDictations.first.categoryName, 'Category B');
    });

    test('updateDictation updates an existing dictation by id', () async {
      final dictation1 = Dictation(
        id: 'd1',
        categoryName: 'A',
        textbookName: 'T1',
        recordings: [],
        createdAt: DateTime.utc(2026, 4, 10),
      );
      final dictation2 = Dictation(
        id: 'd2',
        categoryName: 'B',
        textbookName: 'T2',
        recordings: [],
        createdAt: DateTime.utc(2026, 4, 10),
      );
      await repository.saveDictation(dictation1);
      await repository.saveDictation(dictation2);

      final updatedDictation1 = dictation1.copyWith(textbookName: 'Updated T1');
      await repository.updateDictation(updatedDictation1);

      final loadedDictations = await repository.loadAllDictations();
      expect(loadedDictations.length, 2);
      expect(
        loadedDictations.firstWhere((d) => d.id == 'd1').textbookName,
        'Updated T1',
      );
      expect(
        loadedDictations.firstWhere((d) => d.id == 'd2').textbookName,
        'T2',
      );
    });

    test('updateDictation throws exception if dictation not found', () async {
      final dictation = Dictation(
        id: 'd1',
        categoryName: 'A',
        textbookName: 'T1',
        recordings: [],
        createdAt: DateTime.utc(2026, 4, 10),
      );
      final nonExistentDictation = dictation.copyWith(id: 'nonexistent');

      expect(
        () => repository.updateDictation(nonExistentDictation),
        throwsA(isA<Exception>()),
      );
    });

    test('deleteDictation removes a dictation', () async {
      final dictation = Dictation(
        id: 'dict1',
        categoryName: 'Category A',
        textbookName: 'Textbook 1',
        recordings: [],
        createdAt: DateTime.utc(2026, 4, 10),
      );
      await repository.saveDictation(dictation);

      await repository.deleteDictation('dict1');

      final loadedDictations = await repository.loadAllDictations();
      expect(loadedDictations, isEmpty);
    });

    test('deleteDictation does nothing if dictation not found', () async {
      final dictation = Dictation(
        id: 'dict1',
        categoryName: 'Category A',
        textbookName: 'Textbook 1',
        recordings: [],
        createdAt: DateTime.utc(2026, 4, 10),
      );
      await repository.saveDictation(dictation);

      await repository.deleteDictation('nonexistent');

      final loadedDictations = await repository.loadAllDictations();
      expect(loadedDictations.length, 1);
    });

    test('repository correctly handles multiple dictations', () async {
      final dictation1 = Dictation(
        id: 'd1',
        categoryName: 'Cat1',
        textbookName: 'Tb1',
        recordings: [],
        createdAt: DateTime.utc(2026, 4, 10),
      );
      final dictation2 = Dictation(
        id: 'd2',
        categoryName: 'Cat2',
        textbookName: 'Tb2',
        recordings: [],
        createdAt: DateTime.utc(2026, 4, 11),
      );

      await repository.saveDictation(dictation1);
      await repository.saveDictation(dictation2);

      final loadedDictations = await repository.loadAllDictations();
      expect(loadedDictations.length, 2);
      expect(loadedDictations.any((d) => d.id == 'd1'), isTrue);
      expect(loadedDictations.any((d) => d.id == 'd2'), isTrue);
    });
  });
}
