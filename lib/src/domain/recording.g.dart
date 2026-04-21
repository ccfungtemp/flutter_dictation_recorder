// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recording.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Recording _$RecordingFromJson(Map<String, dynamic> json) => _Recording(
  id: json['id'] as String,
  filePath: json['filePath'] as String,
  durationSeconds: (json['durationSeconds'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  name: json['name'] as String?,
);

Map<String, dynamic> _$RecordingToJson(_Recording instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filePath': instance.filePath,
      'durationSeconds': instance.durationSeconds,
      'createdAt': instance.createdAt.toIso8601String(),
      'name': instance.name,
    };
