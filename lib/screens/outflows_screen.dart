import 'package:flutter/material.dart';
import 'package:finances/widgets/widgets.dart';

class OutflowsScreen extends StatelessWidget {
  const OutflowsScreen({super.key});

  static Color backgroundColor = Color.fromRGBO(238, 238, 238, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomOutflowsTitle(),
            CustomOutflowProgressIndicator(),
            CustomOutflowsExpenseList(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
