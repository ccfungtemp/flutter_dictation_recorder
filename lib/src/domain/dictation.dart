import 'package:freezed_annotation/freezed_annotation.dart';
import 'recording.dart';

part 'dictation.freezed.dart';
part 'dictation.g.dart';

@freezed
abstract class Dictation with _$Dictation {
  const factory Dictation({
    required String id,
    required String categoryName,
    required String textbookName,
    required List<Recording> recordings,
    required DateTime createdAt,
  }) = _Dictation;

  factory Dictation.fromJson(Map<String, dynamic> json) =>
      _$DictationFromJson(json);
}
