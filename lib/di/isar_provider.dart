import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar_community/isar.dart';

final isarProvider = Provider<Isar>(
  (_) => throw UnimplementedError('mainでoverrideされる'),
);
