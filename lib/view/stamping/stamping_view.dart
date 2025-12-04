import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StampingView extends HookConsumerWidget {
  const StampingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('打刻'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('打刻')],
      ),
    );
  }
}
