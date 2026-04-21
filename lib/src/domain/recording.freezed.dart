// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recording.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Recording {

 String get id; String get filePath; int get durationSeconds; DateTime get createdAt; String? get name;
/// Create a copy of Recording
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordingCopyWith<Recording> get copyWith => _$RecordingCopyWithImpl<Recording>(this as Recording, _$identity);

  /// Serializes this Recording to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Recording&&(identical(other.id, id) || other.id == id)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,filePath,durationSeconds,createdAt,name);

@override
String toString() {
  return 'Recording(id: $id, filePath: $filePath, durationSeconds: $durationSeconds, createdAt: $createdAt, name: $name)';
}


}

/// @nodoc
abstract mixin class $RecordingCopyWith<$Res>  {
  factory $RecordingCopyWith(Recording value, $Res Function(Recording) _then) = _$RecordingCopyWithImpl;
@useResult
$Res call({
 String id, String filePath, int durationSeconds, DateTime createdAt, String? name
});




}
/// @nodoc
class _$RecordingCopyWithImpl<$Res>
    implements $RecordingCopyWith<$Res> {
  _$RecordingCopyWithImpl(this._self, this._then);

  final Recording _self;
  final $Res Function(Recording) _then;

/// Create a copy of Recording
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? filePath = null,Object? durationSeconds = null,Object? createdAt = null,Object? name = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Recording].
extension RecordingPatterns on Recording {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Recording value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Recording() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Recording value)  $default,){
final _that = this;
switch (_that) {
case _Recording():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Recording value)?  $default,){
final _that = this;
switch (_that) {
case _Recording() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String filePath,  int durationSeconds,  DateTime createdAt,  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Recording() when $default != null:
return $default(_that.id,_that.filePath,_that.durationSeconds,_that.createdAt,_that.name);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String filePath,  int durationSeconds,  DateTime createdAt,  String? name)  $default,) {final _that = this;
switch (_that) {
case _Recording():
return $default(_that.id,_that.filePath,_that.durationSeconds,_that.createdAt,_that.name);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String filePath,  int durationSeconds,  DateTime createdAt,  String? name)?  $default,) {final _that = this;
switch (_that) {
case _Recording() when $default != null:
return $default(_that.id,_that.filePath,_that.durationSeconds,_that.createdAt,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Recording implements Recording {
  const _Recording({required this.id, required this.filePath, required this.durationSeconds, required this.createdAt, this.name});
  factory _Recording.fromJson(Map<String, dynamic> json) => _$RecordingFromJson(json);

@override final  String id;
@override final  String filePath;
@override final  int durationSeconds;
@override final  DateTime createdAt;
@override final  String? name;

/// Create a copy of Recording
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecordingCopyWith<_Recording> get copyWith => __$RecordingCopyWithImpl<_Recording>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecordingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Recording&&(identical(other.id, id) || other.id == id)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,filePath,durationSeconds,createdAt,name);

@override
String toString() {
  return 'Recording(id: $id, filePath: $filePath, durationSeconds: $durationSeconds, createdAt: $createdAt, name: $name)';
}


}

/// @nodoc
abstract mixin class _$RecordingCopyWith<$Res> implements $RecordingCopyWith<$Res> {
  factory _$RecordingCopyWith(_Recording value, $Res Function(_Recording) _then) = __$RecordingCopyWithImpl;
@override @useResult
$Res call({
 String id, String filePath, int durationSeconds, DateTime createdAt, String? name
});




}
/// @nodoc
class __$RecordingCopyWithImpl<$Res>
    implements _$RecordingCopyWith<$Res> {
  __$RecordingCopyWithImpl(this._self, this._then);

  final _Recording _self;
  final $Res Function(_Recording) _then;

/// Create a copy of Recording
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? filePath = null,Object? durationSeconds = null,Object? createdAt = null,Object? name = freezed,}) {
  return _then(_Recording(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,durationSeconds: null == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
