import 'package:finances/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

class CustomTotalList extends StatelessWidget {
  const CustomTotalList({super.key});

  static Color boxShadow = Color.fromRGBO(238, 238, 238, 1);
  static Color boxColor = Color.fromRGBO(255, 255, 255, 1);

  @override
  Widget build(BuildContext context) {
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
              CustomTotalsContainer(),
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

class CustomTotalsContainer extends StatelessWidget {
  const CustomTotalsContainer({super.key});

  static Color purpleBox = Color(0xFF68548e);
  static Color orangeBox = Color(0xFFffd463);

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        CustomTotalBox(
          bgColor: purpleBox,
          boxIcon: HugeIcons.strokeRoundedMoneyBag01,
          boxTitle: 'Total de Ingresos',
          boxAmount: financeProvider.balance.toStringAsFixed(1),
        ),
        CustomTotalBox(
          bgColor: orangeBox,
          boxIcon: HugeIcons.strokeRoundedCreditCardPos,
          boxTitle: 'Total de Egresos',
          boxAmount: financeProvider.expensesTotal.toStringAsFixed(1),
        ),
        CustomTotalBox(
          bgColor: orangeBox,
          boxIcon: HugeIcons.strokeRoundedSavings,
          boxTitle: 'Total Bruto',
          boxAmount: financeProvider.grossTotal.toStringAsFixed(1),
        ),
        CustomTotalBox(
          bgColor: purpleBox,
          boxIcon: HugeIcons.strokeRoundedPiggyBank,
          boxTitle: 'Total de Ahorro',
          boxAmount: financeProvider.saving.toStringAsFixed(1),
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
  static Color blurBox = Colors.black.withValues(alpha: 0.4);

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
          Positioned.fill(child: Container(color: blurBox)),
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

  static Color buttonColor = Color(0xFF68548e);
  static Color textColor = Colors.white;
  static double borderRadius = 20;

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    int free = (financeProvider.free).toInt();

    var textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: textColor,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Stack(
        children: [
          Center(child: Text('Uso libre: S/ $free', style: textStyle)),
        ],
      ),
    );
  }
}

class CustomPercentageBox extends StatelessWidget {
  const CustomPercentageBox({super.key});

  static Color buttonColor = Color.fromRGBO(255, 212, 99, 1);
  static Color textColor = Colors.black;
  static double borderRadius = 20;

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    int percentage = (financeProvider.percentage * 100).toInt();

    var textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: textColor,
    );

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
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomEditButton extends StatelessWidget {
  const CustomEditButton({super.key});

  static Color buttonColor = Color(0xFF68548e);
  static Color iconColor = Colors.white;
  static double borderRadius = 20;

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(
      context,
      listen: false,
    );

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
