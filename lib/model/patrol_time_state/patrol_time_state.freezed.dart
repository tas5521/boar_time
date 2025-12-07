// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patrol_time_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PatrolTimeState {
  DateTime get date => throw _privateConstructorUsedError;
  DateTime? get start => throw _privateConstructorUsedError;
  DateTime? get end => throw _privateConstructorUsedError;
  Duration get cumulativeDuration => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PatrolTimeStateCopyWith<PatrolTimeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatrolTimeStateCopyWith<$Res> {
  factory $PatrolTimeStateCopyWith(
          PatrolTimeState value, $Res Function(PatrolTimeState) then) =
      _$PatrolTimeStateCopyWithImpl<$Res, PatrolTimeState>;
  @useResult
  $Res call(
      {DateTime date,
      DateTime? start,
      DateTime? end,
      Duration cumulativeDuration});
}

/// @nodoc
class _$PatrolTimeStateCopyWithImpl<$Res, $Val extends PatrolTimeState>
    implements $PatrolTimeStateCopyWith<$Res> {
  _$PatrolTimeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? start = freezed,
    Object? end = freezed,
    Object? cumulativeDuration = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cumulativeDuration: null == cumulativeDuration
          ? _value.cumulativeDuration
          : cumulativeDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatrolTimeStateImplCopyWith<$Res>
    implements $PatrolTimeStateCopyWith<$Res> {
  factory _$$PatrolTimeStateImplCopyWith(_$PatrolTimeStateImpl value,
          $Res Function(_$PatrolTimeStateImpl) then) =
      __$$PatrolTimeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      DateTime? start,
      DateTime? end,
      Duration cumulativeDuration});
}

/// @nodoc
class __$$PatrolTimeStateImplCopyWithImpl<$Res>
    extends _$PatrolTimeStateCopyWithImpl<$Res, _$PatrolTimeStateImpl>
    implements _$$PatrolTimeStateImplCopyWith<$Res> {
  __$$PatrolTimeStateImplCopyWithImpl(
      _$PatrolTimeStateImpl _value, $Res Function(_$PatrolTimeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? start = freezed,
    Object? end = freezed,
    Object? cumulativeDuration = null,
  }) {
    return _then(_$PatrolTimeStateImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      start: freezed == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cumulativeDuration: null == cumulativeDuration
          ? _value.cumulativeDuration
          : cumulativeDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$PatrolTimeStateImpl extends _PatrolTimeState {
  const _$PatrolTimeStateImpl(
      {required this.date,
      this.start,
      this.end,
      this.cumulativeDuration = Duration.zero})
      : super._();

  @override
  final DateTime date;
  @override
  final DateTime? start;
  @override
  final DateTime? end;
  @override
  @JsonKey()
  final Duration cumulativeDuration;

  @override
  String toString() {
    return 'PatrolTimeState(date: $date, start: $start, end: $end, cumulativeDuration: $cumulativeDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatrolTimeStateImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.cumulativeDuration, cumulativeDuration) ||
                other.cumulativeDuration == cumulativeDuration));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, date, start, end, cumulativeDuration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PatrolTimeStateImplCopyWith<_$PatrolTimeStateImpl> get copyWith =>
      __$$PatrolTimeStateImplCopyWithImpl<_$PatrolTimeStateImpl>(
          this, _$identity);
}

abstract class _PatrolTimeState extends PatrolTimeState {
  const factory _PatrolTimeState(
      {required final DateTime date,
      final DateTime? start,
      final DateTime? end,
      final Duration cumulativeDuration}) = _$PatrolTimeStateImpl;
  const _PatrolTimeState._() : super._();

  @override
  DateTime get date;
  @override
  DateTime? get start;
  @override
  DateTime? get end;
  @override
  Duration get cumulativeDuration;
  @override
  @JsonKey(ignore: true)
  _$$PatrolTimeStateImplCopyWith<_$PatrolTimeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
