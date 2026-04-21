// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AudioPlayerState {

 PlayerState get playerState; String? get playingFilePath; String? get currentDictationId;// New field
 int? get currentRecordingIndex;
/// Create a copy of AudioPlayerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioPlayerStateCopyWith<AudioPlayerState> get copyWith => _$AudioPlayerStateCopyWithImpl<AudioPlayerState>(this as AudioPlayerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioPlayerState&&(identical(other.playerState, playerState) || other.playerState == playerState)&&(identical(other.playingFilePath, playingFilePath) || other.playingFilePath == playingFilePath)&&(identical(other.currentDictationId, currentDictationId) || other.currentDictationId == currentDictationId)&&(identical(other.currentRecordingIndex, currentRecordingIndex) || other.currentRecordingIndex == currentRecordingIndex));
}


@override
int get hashCode => Object.hash(runtimeType,playerState,playingFilePath,currentDictationId,currentRecordingIndex);

@override
String toString() {
  return 'AudioPlayerState(playerState: $playerState, playingFilePath: $playingFilePath, currentDictationId: $currentDictationId, currentRecordingIndex: $currentRecordingIndex)';
}


}

/// @nodoc
abstract mixin class $AudioPlayerStateCopyWith<$Res>  {
  factory $AudioPlayerStateCopyWith(AudioPlayerState value, $Res Function(AudioPlayerState) _then) = _$AudioPlayerStateCopyWithImpl;
@useResult
$Res call({
 PlayerState playerState, String? playingFilePath, String? currentDictationId, int? currentRecordingIndex
});




}
/// @nodoc
class _$AudioPlayerStateCopyWithImpl<$Res>
    implements $AudioPlayerStateCopyWith<$Res> {
  _$AudioPlayerStateCopyWithImpl(this._self, this._then);

  final AudioPlayerState _self;
  final $Res Function(AudioPlayerState) _then;

/// Create a copy of AudioPlayerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerState = null,Object? playingFilePath = freezed,Object? currentDictationId = freezed,Object? currentRecordingIndex = freezed,}) {
  return _then(_self.copyWith(
playerState: null == playerState ? _self.playerState : playerState // ignore: cast_nullable_to_non_nullable
as PlayerState,playingFilePath: freezed == playingFilePath ? _self.playingFilePath : playingFilePath // ignore: cast_nullable_to_non_nullable
as String?,currentDictationId: freezed == currentDictationId ? _self.currentDictationId : currentDictationId // ignore: cast_nullable_to_non_nullable
as String?,currentRecordingIndex: freezed == currentRecordingIndex ? _self.currentRecordingIndex : currentRecordingIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AudioPlayerState].
extension AudioPlayerStatePatterns on AudioPlayerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AudioPlayerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AudioPlayerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AudioPlayerState value)  $default,){
final _that = this;
switch (_that) {
case _AudioPlayerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AudioPlayerState value)?  $default,){
final _that = this;
switch (_that) {
case _AudioPlayerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlayerState playerState,  String? playingFilePath,  String? currentDictationId,  int? currentRecordingIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AudioPlayerState() when $default != null:
return $default(_that.playerState,_that.playingFilePath,_that.currentDictationId,_that.currentRecordingIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlayerState playerState,  String? playingFilePath,  String? currentDictationId,  int? currentRecordingIndex)  $default,) {final _that = this;
switch (_that) {
case _AudioPlayerState():
return $default(_that.playerState,_that.playingFilePath,_that.currentDictationId,_that.currentRecordingIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlayerState playerState,  String? playingFilePath,  String? currentDictationId,  int? currentRecordingIndex)?  $default,) {final _that = this;
switch (_that) {
case _AudioPlayerState() when $default != null:
return $default(_that.playerState,_that.playingFilePath,_that.currentDictationId,_that.currentRecordingIndex);case _:
  return null;

}
}

}

/// @nodoc


class _AudioPlayerState implements AudioPlayerState {
  const _AudioPlayerState({this.playerState = PlayerState.stopped, this.playingFilePath, this.currentDictationId, this.currentRecordingIndex});
  

@override@JsonKey() final  PlayerState playerState;
@override final  String? playingFilePath;
@override final  String? currentDictationId;
// New field
@override final  int? currentRecordingIndex;

/// Create a copy of AudioPlayerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioPlayerStateCopyWith<_AudioPlayerState> get copyWith => __$AudioPlayerStateCopyWithImpl<_AudioPlayerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioPlayerState&&(identical(other.playerState, playerState) || other.playerState == playerState)&&(identical(other.playingFilePath, playingFilePath) || other.playingFilePath == playingFilePath)&&(identical(other.currentDictationId, currentDictationId) || other.currentDictationId == currentDictationId)&&(identical(other.currentRecordingIndex, currentRecordingIndex) || other.currentRecordingIndex == currentRecordingIndex));
}


@override
int get hashCode => Object.hash(runtimeType,playerState,playingFilePath,currentDictationId,currentRecordingIndex);

@override
String toString() {
  return 'AudioPlayerState(playerState: $playerState, playingFilePath: $playingFilePath, currentDictationId: $currentDictationId, currentRecordingIndex: $currentRecordingIndex)';
}


}

/// @nodoc
abstract mixin class _$AudioPlayerStateCopyWith<$Res> implements $AudioPlayerStateCopyWith<$Res> {
  factory _$AudioPlayerStateCopyWith(_AudioPlayerState value, $Res Function(_AudioPlayerState) _then) = __$AudioPlayerStateCopyWithImpl;
@override @useResult
$Res call({
 PlayerState playerState, String? playingFilePath, String? currentDictationId, int? currentRecordingIndex
});




}
/// @nodoc
class __$AudioPlayerStateCopyWithImpl<$Res>
    implements _$AudioPlayerStateCopyWith<$Res> {
  __$AudioPlayerStateCopyWithImpl(this._self, this._then);

  final _AudioPlayerState _self;
  final $Res Function(_AudioPlayerState) _then;

/// Create a copy of AudioPlayerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerState = null,Object? playingFilePath = freezed,Object? currentDictationId = freezed,Object? currentRecordingIndex = freezed,}) {
  return _then(_AudioPlayerState(
playerState: null == playerState ? _self.playerState : playerState // ignore: cast_nullable_to_non_nullable
as PlayerState,playingFilePath: freezed == playingFilePath ? _self.playingFilePath : playingFilePath // ignore: cast_nullable_to_non_nullable
as String?,currentDictationId: freezed == currentDictationId ? _self.currentDictationId : currentDictationId // ignore: cast_nullable_to_non_nullable
as String?,currentRecordingIndex: freezed == currentRecordingIndex ? _self.currentRecordingIndex : currentRecordingIndex // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
