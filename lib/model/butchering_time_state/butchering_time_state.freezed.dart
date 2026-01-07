// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'butchering_time_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ButcheringTimeState {

 DateTime get date; DateTime? get start; DateTime? get end; DateTime? get breakStart; DateTime? get breakEnd; Duration get cumulativeDuration;
/// Create a copy of ButcheringTimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ButcheringTimeStateCopyWith<ButcheringTimeState> get copyWith => _$ButcheringTimeStateCopyWithImpl<ButcheringTimeState>(this as ButcheringTimeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ButcheringTimeState&&(identical(other.date, date) || other.date == date)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.breakStart, breakStart) || other.breakStart == breakStart)&&(identical(other.breakEnd, breakEnd) || other.breakEnd == breakEnd)&&(identical(other.cumulativeDuration, cumulativeDuration) || other.cumulativeDuration == cumulativeDuration));
}


@override
int get hashCode => Object.hash(runtimeType,date,start,end,breakStart,breakEnd,cumulativeDuration);

@override
String toString() {
  return 'ButcheringTimeState(date: $date, start: $start, end: $end, breakStart: $breakStart, breakEnd: $breakEnd, cumulativeDuration: $cumulativeDuration)';
}


}

/// @nodoc
abstract mixin class $ButcheringTimeStateCopyWith<$Res>  {
  factory $ButcheringTimeStateCopyWith(ButcheringTimeState value, $Res Function(ButcheringTimeState) _then) = _$ButcheringTimeStateCopyWithImpl;
@useResult
$Res call({
 DateTime date, DateTime? start, DateTime? end, DateTime? breakStart, DateTime? breakEnd, Duration cumulativeDuration
});




}
/// @nodoc
class _$ButcheringTimeStateCopyWithImpl<$Res>
    implements $ButcheringTimeStateCopyWith<$Res> {
  _$ButcheringTimeStateCopyWithImpl(this._self, this._then);

  final ButcheringTimeState _self;
  final $Res Function(ButcheringTimeState) _then;

/// Create a copy of ButcheringTimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? start = freezed,Object? end = freezed,Object? breakStart = freezed,Object? breakEnd = freezed,Object? cumulativeDuration = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,start: freezed == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime?,breakStart: freezed == breakStart ? _self.breakStart : breakStart // ignore: cast_nullable_to_non_nullable
as DateTime?,breakEnd: freezed == breakEnd ? _self.breakEnd : breakEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,cumulativeDuration: null == cumulativeDuration ? _self.cumulativeDuration : cumulativeDuration // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [ButcheringTimeState].
extension ButcheringTimeStatePatterns on ButcheringTimeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ButcheringTimeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ButcheringTimeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ButcheringTimeState value)  $default,){
final _that = this;
switch (_that) {
case _ButcheringTimeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ButcheringTimeState value)?  $default,){
final _that = this;
switch (_that) {
case _ButcheringTimeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  DateTime? start,  DateTime? end,  DateTime? breakStart,  DateTime? breakEnd,  Duration cumulativeDuration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ButcheringTimeState() when $default != null:
return $default(_that.date,_that.start,_that.end,_that.breakStart,_that.breakEnd,_that.cumulativeDuration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  DateTime? start,  DateTime? end,  DateTime? breakStart,  DateTime? breakEnd,  Duration cumulativeDuration)  $default,) {final _that = this;
switch (_that) {
case _ButcheringTimeState():
return $default(_that.date,_that.start,_that.end,_that.breakStart,_that.breakEnd,_that.cumulativeDuration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  DateTime? start,  DateTime? end,  DateTime? breakStart,  DateTime? breakEnd,  Duration cumulativeDuration)?  $default,) {final _that = this;
switch (_that) {
case _ButcheringTimeState() when $default != null:
return $default(_that.date,_that.start,_that.end,_that.breakStart,_that.breakEnd,_that.cumulativeDuration);case _:
  return null;

}
}

}

/// @nodoc


class _ButcheringTimeState extends ButcheringTimeState {
  const _ButcheringTimeState({required this.date, this.start, this.end, this.breakStart, this.breakEnd, this.cumulativeDuration = Duration.zero}): super._();
  

@override final  DateTime date;
@override final  DateTime? start;
@override final  DateTime? end;
@override final  DateTime? breakStart;
@override final  DateTime? breakEnd;
@override@JsonKey() final  Duration cumulativeDuration;

/// Create a copy of ButcheringTimeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ButcheringTimeStateCopyWith<_ButcheringTimeState> get copyWith => __$ButcheringTimeStateCopyWithImpl<_ButcheringTimeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ButcheringTimeState&&(identical(other.date, date) || other.date == date)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.breakStart, breakStart) || other.breakStart == breakStart)&&(identical(other.breakEnd, breakEnd) || other.breakEnd == breakEnd)&&(identical(other.cumulativeDuration, cumulativeDuration) || other.cumulativeDuration == cumulativeDuration));
}


@override
int get hashCode => Object.hash(runtimeType,date,start,end,breakStart,breakEnd,cumulativeDuration);

@override
String toString() {
  return 'ButcheringTimeState(date: $date, start: $start, end: $end, breakStart: $breakStart, breakEnd: $breakEnd, cumulativeDuration: $cumulativeDuration)';
}


}

/// @nodoc
abstract mixin class _$ButcheringTimeStateCopyWith<$Res> implements $ButcheringTimeStateCopyWith<$Res> {
  factory _$ButcheringTimeStateCopyWith(_ButcheringTimeState value, $Res Function(_ButcheringTimeState) _then) = __$ButcheringTimeStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, DateTime? start, DateTime? end, DateTime? breakStart, DateTime? breakEnd, Duration cumulativeDuration
});




}
/// @nodoc
class __$ButcheringTimeStateCopyWithImpl<$Res>
    implements _$ButcheringTimeStateCopyWith<$Res> {
  __$ButcheringTimeStateCopyWithImpl(this._self, this._then);

  final _ButcheringTimeState _self;
  final $Res Function(_ButcheringTimeState) _then;

/// Create a copy of ButcheringTimeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? start = freezed,Object? end = freezed,Object? breakStart = freezed,Object? breakEnd = freezed,Object? cumulativeDuration = null,}) {
  return _then(_ButcheringTimeState(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,start: freezed == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime?,breakStart: freezed == breakStart ? _self.breakStart : breakStart // ignore: cast_nullable_to_non_nullable
as DateTime?,breakEnd: freezed == breakEnd ? _self.breakEnd : breakEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,cumulativeDuration: null == cumulativeDuration ? _self.cumulativeDuration : cumulativeDuration // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
