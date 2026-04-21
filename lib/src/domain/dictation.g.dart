// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Dictation _$DictationFromJson(Map<String, dynamic> json) => _Dictation(
  id: json['id'] as String,
  categoryName: json['categoryName'] as String,
  textbookName: json['textbookName'] as String,
  recordings: (json['recordings'] as List<dynamic>)
      .map((e) => Recording.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$DictationToJson(_Dictation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
      'textbookName': instance.textbookName,
      'recordings': instance.recordings,
      'createdAt': instance.createdAt.toIso8601String(),
    };
