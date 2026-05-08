import 'package:flutter/material.dart';

class CustomInitMessage extends StatelessWidget {
  const CustomInitMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hola Marco!',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            'Bienvenido a Finances',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
