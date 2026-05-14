import 'package:finances/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class CustomTotalList extends StatelessWidget {
  const CustomTotalList({super.key});
  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    Color boxShadow = Color.fromRGBO(238, 238, 238, 1);
    Color boxColor = Color.fromRGBO(255, 255, 255, 1);
    return Stack(
      children: [
        Container(height: 60, decoration: BoxDecoration(color: boxShadow)),
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  CustomTotalBox(
                    bgColor: Color(0xFF68548e),
                    boxIcon: HugeIcons.strokeRoundedMoneyBag01,
                    boxTitle: 'Total de Ingresos',
                    boxAmount: financeProvider.balance.toStringAsFixed(1),
                  ),
                  CustomTotalBox(
                    bgColor: Color(0xFFffd463),
                    boxIcon: HugeIcons.strokeRoundedCreditCardPos,
                    boxTitle: 'Total de Egresos',
                    boxAmount: financeProvider.expensesTotal.toStringAsFixed(1),
                  ),
                  CustomTotalBox(
                    bgColor: Color(0xFFffd463),
                    boxIcon: HugeIcons.strokeRoundedSavings,
                    boxTitle: 'Total Bruto',
                    boxAmount: financeProvider.grossTotal.toStringAsFixed(1),
                  ),
                  CustomTotalBox(
                    bgColor: Color(0xFF68548e),
                    boxIcon: HugeIcons.strokeRoundedPiggyBank,
                    boxTitle: 'Total de Ahorro',
                    boxAmount: financeProvider.saving.toStringAsFixed(1),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CustomFreeBox(),
              SizedBox(height: 10),
              CustomPercentageBox(),
              SizedBox(height: 10),
              CustomEditButton(),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomTotalBox extends StatelessWidget {
  const CustomTotalBox({
    super.key,
    required this.bgColor,
    required this.boxIcon,
    required this.boxTitle,
    required this.boxAmount,
  });

  final Color bgColor;
  final List<List<dynamic>> boxIcon;
  final String boxTitle;
  final dynamic boxAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 30,
            child: HugeIcon(icon: boxIcon, size: 150, color: Colors.white),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.4)),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: HugeIcon(icon: boxIcon, size: 40, color: Colors.white),
          ),

          Positioned(
            bottom: 15,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  boxTitle,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                Text(
                  'S/ $boxAmount',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFreeBox extends StatelessWidget {
  const CustomFreeBox({super.key});

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    Color buttonColor = Color(0xFF68548e);
    Color textColor = Colors.white;
    double borderRadius = 20;

    int free = (financeProvider.free).toInt();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              'Uso libre: S/ $free',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPercentageBox extends StatelessWidget {
  const CustomPercentageBox({super.key});

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    Color buttonColor = Color.fromRGBO(255, 212, 99, 1);
    Color textColor = Colors.black;
    double borderRadius = 20;

    int percentage = (financeProvider.percentage * 100).toInt();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              'Ahorrarás un $percentage % este mes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomEditButton extends StatelessWidget {
  const CustomEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(
      context,
      listen: false,
    );

    Color buttonColor = Color(0xFF68548e);
    Color iconColor = Colors.white;
    double borderRadius = 20;

    return InkWell(
      onTap: () {
        showPercentageForm(context, financeProvider);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Stack(
          children: [
            Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedPencilEdit02,
                size: 30,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showPercentageForm(BuildContext context, FinanceProvider financeProvider) {
  final percentageController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Agregar Nuevo Porcentaje'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: percentageController,
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Total de porcentaje'),
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
            final totalDouble = double.tryParse(percentageController.text);

            if (totalDouble == null || totalDouble == 0) {
              Navigator.pop(context);
              return;
            }

            financeProvider.percentage = totalDouble;
            Navigator.pop(context);
          },
          child: const Text('Guardar'),
        ),
      ],
    ),
  );
}
