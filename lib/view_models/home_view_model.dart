import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone_flutter/providers/provider.dart';

class HomeViewModel {
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  int get pageIdx => _ref.watch(bottomNavPageProvider);
  set pageIdx(int idx) =>
      _ref.watch(bottomNavPageProvider.notifier).update((state) => idx);
}
