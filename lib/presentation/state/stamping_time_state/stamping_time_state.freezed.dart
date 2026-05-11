// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stamping_time_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StampingTimeState {

 DateTime get date; DateTime? get startTime; DateTime? get endTime; DateTime? get breakStart; DateTime? get breakEnd; DateTime? get patrolStart; DateTime? get patrolEnd;
/// Create a copy of StampingTimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StampingTimeStateCopyWith<StampingTimeState> get copyWith => _$StampingTimeStateCopyWithImpl<StampingTimeState>(this as StampingTimeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StampingTimeState&&(identical(other.date, date) || other.date == date)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.breakStart, breakStart) || other.breakStart == breakStart)&&(identical(other.breakEnd, breakEnd) || other.breakEnd == breakEnd)&&(identical(other.patrolStart, patrolStart) || other.patrolStart == patrolStart)&&(identical(other.patrolEnd, patrolEnd) || other.patrolEnd == patrolEnd));
}


@override
int get hashCode => Object.hash(runtimeType,date,startTime,endTime,breakStart,breakEnd,patrolStart,patrolEnd);

@override
String toString() {
  return 'StampingTimeState(date: $date, startTime: $startTime, endTime: $endTime, breakStart: $breakStart, breakEnd: $breakEnd, patrolStart: $patrolStart, patrolEnd: $patrolEnd)';
}


}

/// @nodoc
abstract mixin class $StampingTimeStateCopyWith<$Res>  {
  factory $StampingTimeStateCopyWith(StampingTimeState value, $Res Function(StampingTimeState) _then) = _$StampingTimeStateCopyWithImpl;
@useResult
$Res call({
 DateTime date, DateTime? startTime, DateTime? endTime, DateTime? breakStart, DateTime? breakEnd, DateTime? patrolStart, DateTime? patrolEnd
});




}
/// @nodoc
class _$StampingTimeStateCopyWithImpl<$Res>
    implements $StampingTimeStateCopyWith<$Res> {
  _$StampingTimeStateCopyWithImpl(this._self, this._then);

  final StampingTimeState _self;
  final $Res Function(StampingTimeState) _then;

/// Create a copy of StampingTimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? startTime = freezed,Object? endTime = freezed,Object? breakStart = freezed,Object? breakEnd = freezed,Object? patrolStart = freezed,Object? patrolEnd = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,breakStart: freezed == breakStart ? _self.breakStart : breakStart // ignore: cast_nullable_to_non_nullable
as DateTime?,breakEnd: freezed == breakEnd ? _self.breakEnd : breakEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,patrolStart: freezed == patrolStart ? _self.patrolStart : patrolStart // ignore: cast_nullable_to_non_nullable
as DateTime?,patrolEnd: freezed == patrolEnd ? _self.patrolEnd : patrolEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StampingTimeState].
extension StampingTimeStatePatterns on StampingTimeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StampingTimeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StampingTimeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StampingTimeState value)  $default,){
final _that = this;
switch (_that) {
case _StampingTimeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StampingTimeState value)?  $default,){
final _that = this;
switch (_that) {
case _StampingTimeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  DateTime? startTime,  DateTime? endTime,  DateTime? breakStart,  DateTime? breakEnd,  DateTime? patrolStart,  DateTime? patrolEnd)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StampingTimeState() when $default != null:
return $default(_that.date,_that.startTime,_that.endTime,_that.breakStart,_that.breakEnd,_that.patrolStart,_that.patrolEnd);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  DateTime? startTime,  DateTime? endTime,  DateTime? breakStart,  DateTime? breakEnd,  DateTime? patrolStart,  DateTime? patrolEnd)  $default,) {final _that = this;
switch (_that) {
case _StampingTimeState():
return $default(_that.date,_that.startTime,_that.endTime,_that.breakStart,_that.breakEnd,_that.patrolStart,_that.patrolEnd);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  DateTime? startTime,  DateTime? endTime,  DateTime? breakStart,  DateTime? breakEnd,  DateTime? patrolStart,  DateTime? patrolEnd)?  $default,) {final _that = this;
switch (_that) {
case _StampingTimeState() when $default != null:
return $default(_that.date,_that.startTime,_that.endTime,_that.breakStart,_that.breakEnd,_that.patrolStart,_that.patrolEnd);case _:
  return null;

}
}

}

/// @nodoc


class _StampingTimeState extends StampingTimeState {
  const _StampingTimeState({required this.date, this.startTime, this.endTime, this.breakStart, this.breakEnd, this.patrolStart, this.patrolEnd}): super._();
  

@override final  DateTime date;
@override final  DateTime? startTime;
@override final  DateTime? endTime;
@override final  DateTime? breakStart;
@override final  DateTime? breakEnd;
@override final  DateTime? patrolStart;
@override final  DateTime? patrolEnd;

/// Create a copy of StampingTimeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StampingTimeStateCopyWith<_StampingTimeState> get copyWith => __$StampingTimeStateCopyWithImpl<_StampingTimeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StampingTimeState&&(identical(other.date, date) || other.date == date)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.breakStart, breakStart) || other.breakStart == breakStart)&&(identical(other.breakEnd, breakEnd) || other.breakEnd == breakEnd)&&(identical(other.patrolStart, patrolStart) || other.patrolStart == patrolStart)&&(identical(other.patrolEnd, patrolEnd) || other.patrolEnd == patrolEnd));
}


@override
int get hashCode => Object.hash(runtimeType,date,startTime,endTime,breakStart,breakEnd,patrolStart,patrolEnd);

@override
String toString() {
  return 'StampingTimeState(date: $date, startTime: $startTime, endTime: $endTime, breakStart: $breakStart, breakEnd: $breakEnd, patrolStart: $patrolStart, patrolEnd: $patrolEnd)';
}


}

/// @nodoc
abstract mixin class _$StampingTimeStateCopyWith<$Res> implements $StampingTimeStateCopyWith<$Res> {
  factory _$StampingTimeStateCopyWith(_StampingTimeState value, $Res Function(_StampingTimeState) _then) = __$StampingTimeStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, DateTime? startTime, DateTime? endTime, DateTime? breakStart, DateTime? breakEnd, DateTime? patrolStart, DateTime? patrolEnd
});




}
/// @nodoc
class __$StampingTimeStateCopyWithImpl<$Res>
    implements _$StampingTimeStateCopyWith<$Res> {
  __$StampingTimeStateCopyWithImpl(this._self, this._then);

  final _StampingTimeState _self;
  final $Res Function(_StampingTimeState) _then;

/// Create a copy of StampingTimeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? startTime = freezed,Object? endTime = freezed,Object? breakStart = freezed,Object? breakEnd = freezed,Object? patrolStart = freezed,Object? patrolEnd = freezed,}) {
  return _then(_StampingTimeState(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,breakStart: freezed == breakStart ? _self.breakStart : breakStart // ignore: cast_nullable_to_non_nullable
as DateTime?,breakEnd: freezed == breakEnd ? _self.breakEnd : breakEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,patrolStart: freezed == patrolStart ? _self.patrolStart : patrolStart // ignore: cast_nullable_to_non_nullable
as DateTime?,patrolEnd: freezed == patrolEnd ? _self.patrolEnd : patrolEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
