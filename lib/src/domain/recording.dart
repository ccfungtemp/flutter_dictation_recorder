import 'package:freezed_annotation/freezed_annotation.dart';

part 'recording.freezed.dart';
part 'recording.g.dart';

@freezed
abstract class Recording with _$Recording {
  const factory Recording({
    required String id,
    required String filePath,
    required int durationSeconds,
    required DateTime createdAt,
    String? name,
  }) = _Recording;

  factory Recording.fromJson(Map<String, dynamic> json) =>
      _$RecordingFromJson(json);
}
