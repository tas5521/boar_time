// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:boar_time/app/page/bottom_navigation_bar/bottom_navigation_bar_page.dart'
    as _i1;
import 'package:boar_time/features/butchering/presentation/page/butchering_time_page.dart'
    as _i2;
import 'package:boar_time/features/patrol/presentation/notifier/patrol_time_notifier.dart'
    as _i9;
import 'package:boar_time/features/patrol/presentation/page/patrol_edit_page.dart'
    as _i3;
import 'package:boar_time/features/patrol/presentation/page/patrol_time_page.dart'
    as _i4;
import 'package:boar_time/features/patrol/presentation/state/patrol_time_state/patrol_time_state.dart'
    as _i8;
import 'package:boar_time/features/stamping/presentation/page/stamping_page.dart'
    as _i5;
import 'package:flutter/material.dart' as _i7;

/// generated route for
/// [_i1.BottomNavigationBarPage]
class BottomNavigationBarRoute extends _i6.PageRouteInfo<void> {
  const BottomNavigationBarRoute({List<_i6.PageRouteInfo>? children})
    : super(BottomNavigationBarRoute.name, initialChildren: children);

  static const String name = 'BottomNavigationBarRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.BottomNavigationBarPage();
    },
  );
}

/// generated route for
/// [_i2.ButcheringTimePage]
class ButcheringTimeRoute extends _i6.PageRouteInfo<void> {
  const ButcheringTimeRoute({List<_i6.PageRouteInfo>? children})
    : super(ButcheringTimeRoute.name, initialChildren: children);

  static const String name = 'ButcheringTimeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.ButcheringTimePage();
    },
  );
}

/// generated route for
/// [_i3.PatrolEditPage]
class PatrolEditRoute extends _i6.PageRouteInfo<PatrolEditRouteArgs> {
  PatrolEditRoute({
    _i7.Key? key,
    required _i8.PatrolTimeState patrolTimeState,
    required _i9.PatrolTimeNotifier patrolTimeNotifier,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         PatrolEditRoute.name,
         args: PatrolEditRouteArgs(
           key: key,
           patrolTimeState: patrolTimeState,
           patrolTimeNotifier: patrolTimeNotifier,
         ),
         initialChildren: children,
       );

  static const String name = 'PatrolEditRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PatrolEditRouteArgs>();
      return _i3.PatrolEditPage(
        key: args.key,
        patrolTimeState: args.patrolTimeState,
        patrolTimeNotifier: args.patrolTimeNotifier,
      );
    },
  );
}

class PatrolEditRouteArgs {
  const PatrolEditRouteArgs({
    this.key,
    required this.patrolTimeState,
    required this.patrolTimeNotifier,
  });

  final _i7.Key? key;

  final _i8.PatrolTimeState patrolTimeState;

  final _i9.PatrolTimeNotifier patrolTimeNotifier;

  @override
  String toString() {
    return 'PatrolEditRouteArgs{key: $key, patrolTimeState: $patrolTimeState, patrolTimeNotifier: $patrolTimeNotifier}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PatrolEditRouteArgs) return false;
    return key == other.key &&
        patrolTimeState == other.patrolTimeState &&
        patrolTimeNotifier == other.patrolTimeNotifier;
  }

  @override
  int get hashCode =>
      key.hashCode ^ patrolTimeState.hashCode ^ patrolTimeNotifier.hashCode;
}

/// generated route for
/// [_i4.PatrolTimePage]
class PatrolTimeRoute extends _i6.PageRouteInfo<void> {
  const PatrolTimeRoute({List<_i6.PageRouteInfo>? children})
    : super(PatrolTimeRoute.name, initialChildren: children);

  static const String name = 'PatrolTimeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.PatrolTimePage();
    },
  );
}

/// generated route for
/// [_i5.StampingPage]
class StampingRoute extends _i6.PageRouteInfo<void> {
  const StampingRoute({List<_i6.PageRouteInfo>? children})
    : super(StampingRoute.name, initialChildren: children);

  static const String name = 'StampingRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.StampingPage();
    },
  );
}
