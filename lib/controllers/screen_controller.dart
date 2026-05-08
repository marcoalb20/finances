import 'package:finances/screens/screens.dart';
import 'package:finances/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});

  static Color backgroundColor = Color.fromRGBO(238, 238, 238, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          CustomAppBar(),
          Expanded(
            child: PageView(
              controller: PageController(initialPage: 1),
              children: [StartsScreen(), TotalsScreen(), OutflowsScreen()],
            ),
          ),
        ],
      ),
    );
  }
}
