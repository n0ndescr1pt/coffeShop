import 'package:coffe_shop/src/features/menu/bloc/coffe_list_bloc.dart';
import 'package:coffe_shop/src/features/menu/data/coffe_services.dart';
import 'package:coffe_shop/src/features/menu/utils/scroll_utils.dart';
import 'package:coffe_shop/src/features/widgets/category_listview.dart';
import 'package:coffe_shop/src/features/widgets/coffe_card_widget.dart';
import 'package:coffe_shop/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ItemScrollController itemController = ItemScrollController();
  final ItemPositionsListener itemListener = ItemPositionsListener.create();

  final ItemScrollController categoryItemController = ItemScrollController();

  int currentTub = 0;
  final ScrollUtils _scrollUtils = ScrollUtils();

  final CoffeServices coffeServices = CoffeServices();
  //List<CoffeModel> drinkList = [CoffeModel(title: "null", drinks: [])];
  final CoffeListBloc coffeListBloc = CoffeListBloc();

  @override
  void initState() {
    super.initState();
    coffeListBloc.add(LoadCoffeListEvent(coffeServices: coffeServices));
    //_fetchData();
    itemListener.itemPositions.addListener(_onScrollEvent);
  }

  //void _fetchData() async {
  //  try {
  //    final List<CoffeModel> list = await coffeServices.getData();
  //    setState(() {
  //      drinkList = list;
  //    });
  //  } catch (e) {
  //    print(e);
  //  }
  //}

  void _onScrollEvent() {
    final indices =
        itemListener.itemPositions.value.map((e) => e.index).toList();
    if (currentTub != indices[0]) {
      setState(() {
        currentTub = indices[0];
      });
      _scrollUtils.scrollToDirection(categoryItemController, currentTub);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CoffeListBloc>(
      create: (context) => coffeListBloc,
      child: BlocBuilder<CoffeListBloc, CoffeListState>(
        bloc: coffeListBloc,
        builder: (context, state) {
          if (state is CoffeListLoaded) {
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 50,
                surfaceTintColor: AppColors.backgroundColor,
                backgroundColor: AppColors.backgroundColor,
                titleSpacing: 16,
                centerTitle: true,
                title: SizedBox(
                  height: 35,
                  child: CategoryListView(
                    itemController: itemController,
                    coffeModel: state.coffeList,
                    categoryItemController: categoryItemController,
                    currentTub: currentTub,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ScrollablePositionedList.builder(
                  itemCount: state.coffeList.length,
                  itemScrollController: itemController,
                  itemPositionsListener: itemListener,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.coffeList[index].title,
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: state.coffeList[index].drinks.length,
                          itemBuilder: (BuildContext context, int jindex) {
                            return CoffeCard(
                              drinkModel: state.coffeList[index].drinks[jindex],
                            );
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
            );
          }
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
