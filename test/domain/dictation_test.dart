import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dictation_recorder/src/domain/dictation.dart';
import 'package:flutter_dictation_recorder/src/domain/recording.dart';

void main() {
  group('Dictation', () {
    test('fromJson creates a valid Dictation object', () {
      final json = {
        'id': 'dict123',
        'categoryName': '中文',
        'textbookName': '小學語文第一冊',
        'recordings': [
          {
            'id': 'rec1',
            'filePath': '/path/to/rec1.m4a',
            'durationSeconds': 60,
            'createdAt': '2026-04-10T10:00:00.000Z',
          },
        ],
        'createdAt': '2026-04-10T09:00:00.000Z',
      };
      final dictation = Dictation.fromJson(json);

      expect(dictation.id, 'dict123');
      expect(dictation.categoryName, '中文');
      expect(dictation.textbookName, '小學語文第一冊');
      expect(dictation.recordings.length, 1);
      expect(dictation.recordings.first.id, 'rec1');
      expect(dictation.createdAt, DateTime.parse('2026-04-10T09:00:00.000Z'));
    });

    test('toJson converts Dictation object to valid JSON', () {
      final dictation = Dictation(
        id: 'dict123',
        categoryName: '中文',
        textbookName: '小學語文第一冊',
        recordings: [
          Recording(
            id: 'rec1',
            filePath: '/path/to/rec1.m4a',
            durationSeconds: 60,
            createdAt: DateTime.parse('2026-04-10T10:00:00.000Z'),
          ),
        ],
        createdAt: DateTime.parse('2026-04-10T09:00:00.000Z'),
      );
      final json = dictation.toJson();

      expect(json['id'], 'dict123');
      expect(json['categoryName'], '中文');
      expect(json['textbookName'], '小學語文第一冊');
      expect((json['recordings'] as List).length, 1);
      expect(((json['recordings'] as List).first as Map)['id'], 'rec1');
      expect(json['createdAt'], '2026-04-10T09:00:00.000Z');
    });
  });
}
