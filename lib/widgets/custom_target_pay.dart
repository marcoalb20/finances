import 'package:finances/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class CustomTargetPay extends StatelessWidget {
  const CustomTargetPay({super.key});

  static double targetPadding = 10;
  static double targetBorderRadius = 20;
  static double iconSize = 25;
  static double contentSize = 15;
  static double balanceSize = 30;

  static Color backTargetColor = Color.fromRGBO(255, 212, 99, 1);
  static Color backTargetContentColor = Color.fromRGBO(0, 0, 0, 1);
  static TextStyle backContentStyle = TextStyle(
    fontSize: contentSize,
    color: backTargetContentColor,
  );

  static Color frontTargetColor = Color.fromRGBO(157, 64, 217, 1);
  static Color frontTargetContentColor = Color.fromRGBO(255, 255, 255, 1);
  static TextStyle frontContentStyle = TextStyle(
    fontSize: contentSize,
    color: frontTargetContentColor,
  );

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    return SizedBox(
      height: 240,
      child: Stack(
        children: [
          Container(
            height: 100,
            padding: EdgeInsets.all(targetPadding),
            decoration: BoxDecoration(
              color: backTargetColor,
              borderRadius: BorderRadius.circular(targetBorderRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedCreditCardValidation,
                  size: iconSize,
                  color: backTargetContentColor,
                ),
                SizedBox(width: targetPadding),
                Text('Ingreso total bruto del mes', style: backContentStyle),
              ],
            ),
          ),
          Positioned(
            top: 50,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: frontTargetColor,
                borderRadius: BorderRadius.circular(targetBorderRadius),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(targetPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedCash01,
                          size: iconSize,
                          color: frontTargetContentColor,
                        ),
                        SizedBox(width: targetPadding),
                        Text(
                          'Pagos por trabajo o proyectos',
                          style: frontContentStyle,
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: targetPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Balance', style: frontContentStyle),
                            Text(
                              'S/ ${financeProvider.balance}',
                              style: TextStyle(
                                fontSize: balanceSize,
                                fontWeight: FontWeight.bold,
                                color: frontTargetContentColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Día de pago', style: frontContentStyle),
                            Text('31/05', style: frontContentStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(targetPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Recuerda', style: frontContentStyle),
                            Text(
                              'Actualizar al recibir un pago',
                              style: frontContentStyle,
                            ),
                          ],
                        ),
                      ),
                      CustomTargetPayButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTargetPayButton extends StatelessWidget {
  const CustomTargetPayButton({super.key});

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(
      context,
      listen: false,
    );

    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: InkWell(
        onTap: () {
          showBalanceForm(context, financeProvider);
        },
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedEdit01,
                  size: 15,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 5),
              Text(
                'Act.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showBalanceForm(BuildContext context, FinanceProvider financeProvider) {
  final balanceController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Agregar Nuevo Balance'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: balanceController,
            decoration: const InputDecoration(labelText: 'Nuevo Balance'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            final balance = double.tryParse(balanceController.text) ?? 0.0;

            financeProvider.balance = balance;

            Navigator.pop(context);
          },
          child: const Text('Guardar'),
        ),
      ],
    ),
  );
}
