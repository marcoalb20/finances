import 'package:finances/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:finances/models/expenses_model.dart';
import 'package:intl/intl.dart';

class CustomOutflowsExpenseList extends StatelessWidget {
  const CustomOutflowsExpenseList({super.key});

  static Color boxColor = Colors.white;
  static double borderRadius = 20;

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  CustomAddExpenseButton(),
                  SizedBox(height: 10),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 300, minHeight: 0),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CustomExpensesPers(
                          itemId: index,
                          itemText: financeProvider.expensesPers[index].name,
                          monthText: financeProvider.expensesPers[index].month,
                          mountText: financeProvider.expensesPers[index].amount,
                        );
                      },
                      itemCount: financeProvider.expensesPers.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAddExpenseButton extends StatelessWidget {
  const CustomAddExpenseButton({super.key});

  static Color buttonColor = Color.fromRGBO(238, 238, 238, 1);
  static Color iconColor = Colors.black;
  static double borderRadius = 20;

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(
      context,
      listen: false,
    );

    return InkWell(
      onTap: () {
        showExpensesPersForm(context, financeProvider);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: HugeIcon(
          icon: HugeIcons.strokeRoundedAdd01,
          size: 30,
          color: iconColor,
        ),
      ),
    );
  }
}

class CustomExpensesPers extends StatefulWidget {
  const CustomExpensesPers({
    super.key,
    required this.itemText,
    required this.monthText,
    required this.mountText,
    required this.itemId,
  });

  final int itemId;
  final String itemText;
  final String monthText;
  final double mountText;

  static Color buttonColor = Color.fromRGBO(238, 238, 238, 1);
  static Color iconColor = Colors.black;
  static Color textColor = Colors.black;
  static Color secondTextColor = Color.fromARGB(255, 96, 96, 96);
  static double borderRadius = 20;

  @override
  State<CustomExpensesPers> createState() => _CustomExpensesPersState();
}

class _CustomExpensesPersState extends State<CustomExpensesPers> {
  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(
      context,
      listen: false,
    );
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    financeProvider.removeExpensePers(widget.itemId);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: CustomExpensesPers.buttonColor,
                      borderRadius: BorderRadius.circular(
                        CustomExpensesPers.borderRadius,
                      ),
                    ),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedRobot02,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.itemText,
                      style: TextStyle(
                        fontSize: 20,
                        color: CustomExpensesPers.textColor,
                        height: 1.0,
                      ),
                    ),
                    Text(
                      widget.monthText,
                      style: TextStyle(
                        fontSize: 15,
                        color: CustomExpensesPers.secondTextColor,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              'S/ ${widget.mountText}',
              style: TextStyle(
                fontSize: 20,
                color: CustomExpensesPers.textColor,
                fontWeight: FontWeight.bold,
                // height: 1.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

void showExpensesPersForm(BuildContext context, FinanceProvider financeProvider) {
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Agregar Nuevo Gasto'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Nombre del gasto'),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Monto'),
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
            final name = nameController.text;
            final month = DateFormat('dd/MM/yyyy').format(DateTime.now());
            final amount = double.tryParse(amountController.text) ?? 0.0;

            if (name.isNotEmpty) {
              final nuevoGasto = ExpensesModel(
                name: name,
                month: month,
                amount: amount,
              );

              financeProvider.addExpensePers = nuevoGasto;

              Navigator.pop(context);
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    ),
  );
}
