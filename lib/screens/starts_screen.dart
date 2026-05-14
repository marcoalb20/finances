import 'package:finances/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StartsScreen extends StatelessWidget {
  const StartsScreen({super.key});

  // HugeIcons.strokeroundedSun01

  static Color backgroundColor = Color.fromRGBO(238, 238, 238, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              CustomInitMessage(),
              SizedBox(height: 10),
              CustomTargetPay(),
              CustomStartList(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
