// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stamping_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StampingTimeState {
  DateTime get date => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  DateTime? get breakStart => throw _privateConstructorUsedError;
  DateTime? get breakEnd => throw _privateConstructorUsedError;
  DateTime? get patrolStart => throw _privateConstructorUsedError;
  DateTime? get patrolEnd => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StampingTimeStateCopyWith<StampingTimeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StampingTimeStateCopyWith<$Res> {
  factory $StampingTimeStateCopyWith(
          StampingTimeState value, $Res Function(StampingTimeState) then) =
      _$StampingTimeStateCopyWithImpl<$Res, StampingTimeState>;
  @useResult
  $Res call(
      {DateTime date,
      DateTime? startTime,
      DateTime? endTime,
      DateTime? breakStart,
      DateTime? breakEnd,
      DateTime? patrolStart,
      DateTime? patrolEnd});
}

/// @nodoc
class _$StampingTimeStateCopyWithImpl<$Res, $Val extends StampingTimeState>
    implements $StampingTimeStateCopyWith<$Res> {
  _$StampingTimeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? breakStart = freezed,
    Object? breakEnd = freezed,
    Object? patrolStart = freezed,
    Object? patrolEnd = freezed,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      breakStart: freezed == breakStart
          ? _value.breakStart
          : breakStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      breakEnd: freezed == breakEnd
          ? _value.breakEnd
          : breakEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      patrolStart: freezed == patrolStart
          ? _value.patrolStart
          : patrolStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      patrolEnd: freezed == patrolEnd
          ? _value.patrolEnd
          : patrolEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StampingTimeStateImplCopyWith<$Res>
    implements $StampingTimeStateCopyWith<$Res> {
  factory _$$StampingTimeStateImplCopyWith(_$StampingTimeStateImpl value,
          $Res Function(_$StampingTimeStateImpl) then) =
      __$$StampingTimeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      DateTime? startTime,
      DateTime? endTime,
      DateTime? breakStart,
      DateTime? breakEnd,
      DateTime? patrolStart,
      DateTime? patrolEnd});
}

/// @nodoc
class __$$StampingTimeStateImplCopyWithImpl<$Res>
    extends _$StampingTimeStateCopyWithImpl<$Res, _$StampingTimeStateImpl>
    implements _$$StampingTimeStateImplCopyWith<$Res> {
  __$$StampingTimeStateImplCopyWithImpl(_$StampingTimeStateImpl _value,
      $Res Function(_$StampingTimeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? breakStart = freezed,
    Object? breakEnd = freezed,
    Object? patrolStart = freezed,
    Object? patrolEnd = freezed,
  }) {
    return _then(_$StampingTimeStateImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      breakStart: freezed == breakStart
          ? _value.breakStart
          : breakStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      breakEnd: freezed == breakEnd
          ? _value.breakEnd
          : breakEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      patrolStart: freezed == patrolStart
          ? _value.patrolStart
          : patrolStart // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      patrolEnd: freezed == patrolEnd
          ? _value.patrolEnd
          : patrolEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$StampingTimeStateImpl extends _StampingTimeState {
  const _$StampingTimeStateImpl(
      {required this.date,
      this.startTime,
      this.endTime,
      this.breakStart,
      this.breakEnd,
      this.patrolStart,
      this.patrolEnd})
      : super._();

  @override
  final DateTime date;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final DateTime? breakStart;
  @override
  final DateTime? breakEnd;
  @override
  final DateTime? patrolStart;
  @override
  final DateTime? patrolEnd;

  @override
  String toString() {
    return 'StampingTimeState(date: $date, startTime: $startTime, endTime: $endTime, breakStart: $breakStart, breakEnd: $breakEnd, patrolStart: $patrolStart, patrolEnd: $patrolEnd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StampingTimeStateImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.breakStart, breakStart) ||
                other.breakStart == breakStart) &&
            (identical(other.breakEnd, breakEnd) ||
                other.breakEnd == breakEnd) &&
            (identical(other.patrolStart, patrolStart) ||
                other.patrolStart == patrolStart) &&
            (identical(other.patrolEnd, patrolEnd) ||
                other.patrolEnd == patrolEnd));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, startTime, endTime,
      breakStart, breakEnd, patrolStart, patrolEnd);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StampingTimeStateImplCopyWith<_$StampingTimeStateImpl> get copyWith =>
      __$$StampingTimeStateImplCopyWithImpl<_$StampingTimeStateImpl>(
          this, _$identity);
}

abstract class _StampingTimeState extends StampingTimeState {
  const factory _StampingTimeState(
      {required final DateTime date,
      final DateTime? startTime,
      final DateTime? endTime,
      final DateTime? breakStart,
      final DateTime? breakEnd,
      final DateTime? patrolStart,
      final DateTime? patrolEnd}) = _$StampingTimeStateImpl;
  const _StampingTimeState._() : super._();

  @override
  DateTime get date;
  @override
  DateTime? get startTime;
  @override
  DateTime? get endTime;
  @override
  DateTime? get breakStart;
  @override
  DateTime? get breakEnd;
  @override
  DateTime? get patrolStart;
  @override
  DateTime? get patrolEnd;
  @override
  @JsonKey(ignore: true)
  _$$StampingTimeStateImplCopyWith<_$StampingTimeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
