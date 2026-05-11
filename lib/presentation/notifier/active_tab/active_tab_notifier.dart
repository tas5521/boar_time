import 'package:hooks_riverpod/hooks_riverpod.dart';

final activeTabProvider = NotifierProvider<ActiveTabNotifier, int>(
  ActiveTabNotifier.new,
);

class ActiveTabNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setActiveTabIndex(int tabIndex) => state = tabIndex;
}
