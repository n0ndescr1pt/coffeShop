import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ScrollUtils {
  void scrollToDirection(
      ItemScrollController itemScrollController, int index) {
    itemScrollController.scrollTo(
        index: index, duration: const Duration(milliseconds: 150));
  }
}
