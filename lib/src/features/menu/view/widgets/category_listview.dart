import 'package:coffe_shop/src/features/menu/models/coffee_model.dart';
import 'package:coffe_shop/src/features/menu/utils/scroll_utils.dart';
import 'package:coffe_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CategoryListView extends StatefulWidget {
  final List<CoffeModel> coffeModel;
  final ItemScrollController categoryItemController;
  final ItemScrollController itemController;
  final int currentTub;
  const CategoryListView(
      {super.key,
      required this.coffeModel,
      required this.currentTub,
      required this.categoryItemController,
      required this.itemController});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  late int currentTub;

  @override
  void initState() {
    super.initState();
    currentTub = widget.currentTub;
  }

  @override
  Widget build(BuildContext context) {
    final ScrollUtils scrollUtils = ScrollUtils();

    return ScrollablePositionedList.separated(
      itemScrollController: widget.categoryItemController,
      scrollDirection: Axis.horizontal,
      itemCount: widget.coffeModel.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: widget.currentTub == index
                ? AppColors.mainColor
                : AppColors.whiteColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
          ),
          onPressed: () {
            setState(() {
              currentTub = index;
            });
            scrollUtils.scrollToDirection(
                widget.categoryItemController, currentTub);
            scrollUtils.scrollToDirection(
                widget.itemController, currentTub);
          },
          child: Text(
            widget.coffeModel[index].title,
            style: TextStyle(
              fontSize: 14,
              color: widget.currentTub == index
                  ? AppColors.whiteColor
                  : AppColors.textColor,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 8);
      },
    );
  }
}
