import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchViewModel {
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }
}
