// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recording_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecordingState {

 bool get isRecording; Duration get duration; String? get recordingPath; Exception? get error;
/// Create a copy of RecordingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecordingStateCopyWith<RecordingState> get copyWith => _$RecordingStateCopyWithImpl<RecordingState>(this as RecordingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecordingState&&(identical(other.isRecording, isRecording) || other.isRecording == isRecording)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.recordingPath, recordingPath) || other.recordingPath == recordingPath)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isRecording,duration,recordingPath,error);

@override
String toString() {
  return 'RecordingState(isRecording: $isRecording, duration: $duration, recordingPath: $recordingPath, error: $error)';
}


}

/// @nodoc
abstract mixin class $RecordingStateCopyWith<$Res>  {
  factory $RecordingStateCopyWith(RecordingState value, $Res Function(RecordingState) _then) = _$RecordingStateCopyWithImpl;
@useResult
$Res call({
 bool isRecording, Duration duration, String? recordingPath, Exception? error
});




}
/// @nodoc
class _$RecordingStateCopyWithImpl<$Res>
    implements $RecordingStateCopyWith<$Res> {
  _$RecordingStateCopyWithImpl(this._self, this._then);

  final RecordingState _self;
  final $Res Function(RecordingState) _then;

/// Create a copy of RecordingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isRecording = null,Object? duration = null,Object? recordingPath = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
isRecording: null == isRecording ? _self.isRecording : isRecording // ignore: cast_nullable_to_non_nullable
as bool,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,recordingPath: freezed == recordingPath ? _self.recordingPath : recordingPath // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Exception?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecordingState].
extension RecordingStatePatterns on RecordingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecordingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecordingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecordingState value)  $default,){
final _that = this;
switch (_that) {
case _RecordingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecordingState value)?  $default,){
final _that = this;
switch (_that) {
case _RecordingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isRecording,  Duration duration,  String? recordingPath,  Exception? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecordingState() when $default != null:
return $default(_that.isRecording,_that.duration,_that.recordingPath,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isRecording,  Duration duration,  String? recordingPath,  Exception? error)  $default,) {final _that = this;
switch (_that) {
case _RecordingState():
return $default(_that.isRecording,_that.duration,_that.recordingPath,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isRecording,  Duration duration,  String? recordingPath,  Exception? error)?  $default,) {final _that = this;
switch (_that) {
case _RecordingState() when $default != null:
return $default(_that.isRecording,_that.duration,_that.recordingPath,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _RecordingState implements RecordingState {
  const _RecordingState({this.isRecording = false, this.duration = Duration.zero, this.recordingPath, this.error});
  

@override@JsonKey() final  bool isRecording;
@override@JsonKey() final  Duration duration;
@override final  String? recordingPath;
@override final  Exception? error;

/// Create a copy of RecordingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecordingStateCopyWith<_RecordingState> get copyWith => __$RecordingStateCopyWithImpl<_RecordingState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecordingState&&(identical(other.isRecording, isRecording) || other.isRecording == isRecording)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.recordingPath, recordingPath) || other.recordingPath == recordingPath)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isRecording,duration,recordingPath,error);

@override
String toString() {
  return 'RecordingState(isRecording: $isRecording, duration: $duration, recordingPath: $recordingPath, error: $error)';
}


}

/// @nodoc
abstract mixin class _$RecordingStateCopyWith<$Res> implements $RecordingStateCopyWith<$Res> {
  factory _$RecordingStateCopyWith(_RecordingState value, $Res Function(_RecordingState) _then) = __$RecordingStateCopyWithImpl;
@override @useResult
$Res call({
 bool isRecording, Duration duration, String? recordingPath, Exception? error
});




}
/// @nodoc
class __$RecordingStateCopyWithImpl<$Res>
    implements _$RecordingStateCopyWith<$Res> {
  __$RecordingStateCopyWithImpl(this._self, this._then);

  final _RecordingState _self;
  final $Res Function(_RecordingState) _then;

/// Create a copy of RecordingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isRecording = null,Object? duration = null,Object? recordingPath = freezed,Object? error = freezed,}) {
  return _then(_RecordingState(
isRecording: null == isRecording ? _self.isRecording : isRecording // ignore: cast_nullable_to_non_nullable
as bool,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,recordingPath: freezed == recordingPath ? _self.recordingPath : recordingPath // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Exception?,
  ));
}


}

// dart format on
