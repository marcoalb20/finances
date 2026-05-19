import 'package:finances/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomStartTitle extends StatelessWidget {
  const CustomStartTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(
      context,
      // listen: false,
    );

    String user = financeProvider.user;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hola $user!',
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
