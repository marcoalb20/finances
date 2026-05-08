import 'package:flutter/material.dart';
import 'package:finances/widgets/widgets.dart';

class TotalsScreen extends StatelessWidget {
  const TotalsScreen({super.key});

  static Color backgroundColor = Color.fromRGBO(238, 238, 238, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Color.fromRGBO(255, 212, 99, 1),
              child: Center(
                child: Text(
                  'Visualiza tus totales',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Stack(),
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.red.shade200,
            ),
          ],
        ),
      ),
    );
  }
}
