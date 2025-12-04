import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatrolTimeView extends HookConsumerWidget {
  const PatrolTimeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('見回り時間'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('見回り時間')],
      ),
    );
  }
}
