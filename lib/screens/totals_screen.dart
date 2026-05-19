import 'package:flutter/material.dart';
import 'package:finances/widgets/widgets.dart';

class TotalsScreen extends StatelessWidget {
  const TotalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Color.fromRGBO(255, 255, 255, 1);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(children: [CustomTotalTitle(), CustomTotalBalanceList()]),
      ),
    );
  }
}
