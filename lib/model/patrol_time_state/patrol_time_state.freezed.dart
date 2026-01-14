// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patrol_time_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PatrolTimeState {

 int get id; DateTime get date; DateTime? get start; DateTime? get end; PatrolLabel get label; String? get worker; String? get location; String? get animal; int? get count; String? get note;
/// Create a copy of PatrolTimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatrolTimeStateCopyWith<PatrolTimeState> get copyWith => _$PatrolTimeStateCopyWithImpl<PatrolTimeState>(this as PatrolTimeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PatrolTimeState&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.label, label) || other.label == label)&&(identical(other.worker, worker) || other.worker == worker)&&(identical(other.location, location) || other.location == location)&&(identical(other.animal, animal) || other.animal == animal)&&(identical(other.count, count) || other.count == count)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,start,end,label,worker,location,animal,count,note);

@override
String toString() {
  return 'PatrolTimeState(id: $id, date: $date, start: $start, end: $end, label: $label, worker: $worker, location: $location, animal: $animal, count: $count, note: $note)';
}


}

/// @nodoc
abstract mixin class $PatrolTimeStateCopyWith<$Res>  {
  factory $PatrolTimeStateCopyWith(PatrolTimeState value, $Res Function(PatrolTimeState) _then) = _$PatrolTimeStateCopyWithImpl;
@useResult
$Res call({
 int id, DateTime date, DateTime? start, DateTime? end, PatrolLabel label, String? worker, String? location, String? animal, int? count, String? note
});




}
/// @nodoc
class _$PatrolTimeStateCopyWithImpl<$Res>
    implements $PatrolTimeStateCopyWith<$Res> {
  _$PatrolTimeStateCopyWithImpl(this._self, this._then);

  final PatrolTimeState _self;
  final $Res Function(PatrolTimeState) _then;

/// Create a copy of PatrolTimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? date = null,Object? start = freezed,Object? end = freezed,Object? label = null,Object? worker = freezed,Object? location = freezed,Object? animal = freezed,Object? count = freezed,Object? note = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,start: freezed == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as PatrolLabel,worker: freezed == worker ? _self.worker : worker // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,animal: freezed == animal ? _self.animal : animal // ignore: cast_nullable_to_non_nullable
as String?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PatrolTimeState].
extension PatrolTimeStatePatterns on PatrolTimeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PatrolTimeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PatrolTimeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PatrolTimeState value)  $default,){
final _that = this;
switch (_that) {
case _PatrolTimeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PatrolTimeState value)?  $default,){
final _that = this;
switch (_that) {
case _PatrolTimeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime date,  DateTime? start,  DateTime? end,  PatrolLabel label,  String? worker,  String? location,  String? animal,  int? count,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PatrolTimeState() when $default != null:
return $default(_that.id,_that.date,_that.start,_that.end,_that.label,_that.worker,_that.location,_that.animal,_that.count,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime date,  DateTime? start,  DateTime? end,  PatrolLabel label,  String? worker,  String? location,  String? animal,  int? count,  String? note)  $default,) {final _that = this;
switch (_that) {
case _PatrolTimeState():
return $default(_that.id,_that.date,_that.start,_that.end,_that.label,_that.worker,_that.location,_that.animal,_that.count,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime date,  DateTime? start,  DateTime? end,  PatrolLabel label,  String? worker,  String? location,  String? animal,  int? count,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _PatrolTimeState() when $default != null:
return $default(_that.id,_that.date,_that.start,_that.end,_that.label,_that.worker,_that.location,_that.animal,_that.count,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _PatrolTimeState extends PatrolTimeState {
  const _PatrolTimeState({required this.id, required this.date, this.start, this.end, required this.label, this.worker, this.location, this.animal, this.count, this.note}): super._();
  

@override final  int id;
@override final  DateTime date;
@override final  DateTime? start;
@override final  DateTime? end;
@override final  PatrolLabel label;
@override final  String? worker;
@override final  String? location;
@override final  String? animal;
@override final  int? count;
@override final  String? note;

/// Create a copy of PatrolTimeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PatrolTimeStateCopyWith<_PatrolTimeState> get copyWith => __$PatrolTimeStateCopyWithImpl<_PatrolTimeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PatrolTimeState&&(identical(other.id, id) || other.id == id)&&(identical(other.date, date) || other.date == date)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.label, label) || other.label == label)&&(identical(other.worker, worker) || other.worker == worker)&&(identical(other.location, location) || other.location == location)&&(identical(other.animal, animal) || other.animal == animal)&&(identical(other.count, count) || other.count == count)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,id,date,start,end,label,worker,location,animal,count,note);

@override
String toString() {
  return 'PatrolTimeState(id: $id, date: $date, start: $start, end: $end, label: $label, worker: $worker, location: $location, animal: $animal, count: $count, note: $note)';
}


}

/// @nodoc
abstract mixin class _$PatrolTimeStateCopyWith<$Res> implements $PatrolTimeStateCopyWith<$Res> {
  factory _$PatrolTimeStateCopyWith(_PatrolTimeState value, $Res Function(_PatrolTimeState) _then) = __$PatrolTimeStateCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime date, DateTime? start, DateTime? end, PatrolLabel label, String? worker, String? location, String? animal, int? count, String? note
});




}
/// @nodoc
class __$PatrolTimeStateCopyWithImpl<$Res>
    implements _$PatrolTimeStateCopyWith<$Res> {
  __$PatrolTimeStateCopyWithImpl(this._self, this._then);

  final _PatrolTimeState _self;
  final $Res Function(_PatrolTimeState) _then;

/// Create a copy of PatrolTimeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? date = null,Object? start = freezed,Object? end = freezed,Object? label = null,Object? worker = freezed,Object? location = freezed,Object? animal = freezed,Object? count = freezed,Object? note = freezed,}) {
  return _then(_PatrolTimeState(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,start: freezed == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime?,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as PatrolLabel,worker: freezed == worker ? _self.worker : worker // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,animal: freezed == animal ? _self.animal : animal // ignore: cast_nullable_to_non_nullable
as String?,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
