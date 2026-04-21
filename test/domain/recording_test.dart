import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dictation_recorder/src/domain/recording.dart';

void main() {
  group('Recording', () {
    test('fromJson creates a valid Recording object', () {
      final json = {
        'id': 'rec123',
        'filePath': '/path/to/rec123.m4a',
        'durationSeconds': 120,
        'createdAt': '2026-04-10T10:00:00.000Z',
      };
      final recording = Recording.fromJson(json);

      expect(recording.id, 'rec123');
      expect(recording.filePath, '/path/to/rec123.m4a');
      expect(recording.durationSeconds, 120);
      expect(recording.createdAt, DateTime.parse('2026-04-10T10:00:00.000Z'));
    });

    test('toJson converts Recording object to valid JSON', () {
      final recording = Recording(
        id: 'rec123',
        filePath: '/path/to/rec123.m4a',
        durationSeconds: 120,
        createdAt: DateTime.parse('2026-04-10T10:00:00.000Z'),
      );
      final json = recording.toJson();

      expect(json['id'], 'rec123');
      expect(json['filePath'], '/path/to/rec123.m4a');
      expect(json['durationSeconds'], 120);
      expect(json['createdAt'], '2026-04-10T10:00:00.000Z');
    });
  });
}
