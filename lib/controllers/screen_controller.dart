import 'package:finances/providers/page_provider.dart';
import 'package:finances/screens/screens.dart';
import 'package:finances/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:floaty_nav_bar/floaty_nav_bar.dart';

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});

  static Color backgroundColor = Color.fromRGBO(238, 238, 238, 1);

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context);
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          CustomAppBar(),
          Expanded(
            child: PageView(
              controller: pageProvider.pageController,
              children: [StartsScreen(), TotalsScreen(), OutflowsScreen()],
            ),
          ),
        ],
      ),
      bottomNavigationBar: FloatyNavBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        tabs: [
          FloatyTab(
            isSelected: pageProvider.actualPage == 0,
            title: 'Balance',
            icon: HugeIcon(icon: HugeIcons.strokeRoundedBalanceScale),
            onTap: () {
              pageProvider.goToPage(0);
            },
          ),
          FloatyTab(
            isSelected: pageProvider.actualPage == 1,
            title: 'Totales',
            icon: HugeIcon(icon: HugeIcons.strokeRoundedBorderFull),
            onTap: () {
              pageProvider.goToPage(1);
            },
          ),
          FloatyTab(
            isSelected: pageProvider.actualPage == 2,
            title: 'Egresos',
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedShoppingBasketFavorite01,
            ),
            onTap: () {
              pageProvider.goToPage(2);
            },
          ),
        ],
        selectedTab: 0,
      ),
    );
  }
}
