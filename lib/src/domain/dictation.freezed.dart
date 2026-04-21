// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dictation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Dictation {

 String get id; String get categoryName; String get textbookName; List<Recording> get recordings; DateTime get createdAt;
/// Create a copy of Dictation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DictationCopyWith<Dictation> get copyWith => _$DictationCopyWithImpl<Dictation>(this as Dictation, _$identity);

  /// Serializes this Dictation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Dictation&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.textbookName, textbookName) || other.textbookName == textbookName)&&const DeepCollectionEquality().equals(other.recordings, recordings)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryName,textbookName,const DeepCollectionEquality().hash(recordings),createdAt);

@override
String toString() {
  return 'Dictation(id: $id, categoryName: $categoryName, textbookName: $textbookName, recordings: $recordings, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DictationCopyWith<$Res>  {
  factory $DictationCopyWith(Dictation value, $Res Function(Dictation) _then) = _$DictationCopyWithImpl;
@useResult
$Res call({
 String id, String categoryName, String textbookName, List<Recording> recordings, DateTime createdAt
});




}
/// @nodoc
class _$DictationCopyWithImpl<$Res>
    implements $DictationCopyWith<$Res> {
  _$DictationCopyWithImpl(this._self, this._then);

  final Dictation _self;
  final $Res Function(Dictation) _then;

/// Create a copy of Dictation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? categoryName = null,Object? textbookName = null,Object? recordings = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,textbookName: null == textbookName ? _self.textbookName : textbookName // ignore: cast_nullable_to_non_nullable
as String,recordings: null == recordings ? _self.recordings : recordings // ignore: cast_nullable_to_non_nullable
as List<Recording>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Dictation].
extension DictationPatterns on Dictation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Dictation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Dictation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Dictation value)  $default,){
final _that = this;
switch (_that) {
case _Dictation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Dictation value)?  $default,){
final _that = this;
switch (_that) {
case _Dictation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String categoryName,  String textbookName,  List<Recording> recordings,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Dictation() when $default != null:
return $default(_that.id,_that.categoryName,_that.textbookName,_that.recordings,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String categoryName,  String textbookName,  List<Recording> recordings,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Dictation():
return $default(_that.id,_that.categoryName,_that.textbookName,_that.recordings,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String categoryName,  String textbookName,  List<Recording> recordings,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Dictation() when $default != null:
return $default(_that.id,_that.categoryName,_that.textbookName,_that.recordings,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Dictation implements Dictation {
  const _Dictation({required this.id, required this.categoryName, required this.textbookName, required final  List<Recording> recordings, required this.createdAt}): _recordings = recordings;
  factory _Dictation.fromJson(Map<String, dynamic> json) => _$DictationFromJson(json);

@override final  String id;
@override final  String categoryName;
@override final  String textbookName;
 final  List<Recording> _recordings;
@override List<Recording> get recordings {
  if (_recordings is EqualUnmodifiableListView) return _recordings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recordings);
}

@override final  DateTime createdAt;

/// Create a copy of Dictation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DictationCopyWith<_Dictation> get copyWith => __$DictationCopyWithImpl<_Dictation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DictationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Dictation&&(identical(other.id, id) || other.id == id)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.textbookName, textbookName) || other.textbookName == textbookName)&&const DeepCollectionEquality().equals(other._recordings, _recordings)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,categoryName,textbookName,const DeepCollectionEquality().hash(_recordings),createdAt);

@override
String toString() {
  return 'Dictation(id: $id, categoryName: $categoryName, textbookName: $textbookName, recordings: $recordings, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DictationCopyWith<$Res> implements $DictationCopyWith<$Res> {
  factory _$DictationCopyWith(_Dictation value, $Res Function(_Dictation) _then) = __$DictationCopyWithImpl;
@override @useResult
$Res call({
 String id, String categoryName, String textbookName, List<Recording> recordings, DateTime createdAt
});




}
/// @nodoc
class __$DictationCopyWithImpl<$Res>
    implements _$DictationCopyWith<$Res> {
  __$DictationCopyWithImpl(this._self, this._then);

  final _Dictation _self;
  final $Res Function(_Dictation) _then;

/// Create a copy of Dictation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? categoryName = null,Object? textbookName = null,Object? recordings = null,Object? createdAt = null,}) {
  return _then(_Dictation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,textbookName: null == textbookName ? _self.textbookName : textbookName // ignore: cast_nullable_to_non_nullable
as String,recordings: null == recordings ? _self._recordings : recordings // ignore: cast_nullable_to_non_nullable
as List<Recording>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
