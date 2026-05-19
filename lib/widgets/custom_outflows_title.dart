import 'package:flutter/material.dart';

class CustomOutflowsTitle extends StatelessWidget {
  const CustomOutflowsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Text(
          'Seguimiento de egresos',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
