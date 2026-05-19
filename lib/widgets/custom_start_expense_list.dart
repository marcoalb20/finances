import 'package:finances/providers/finance_provider.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';
import 'package:finances/models/expenses_model.dart';
import 'package:intl/intl.dart';

class CustomStartExpenseList extends StatelessWidget {
  const CustomStartExpenseList({super.key});

  static Color boxColor = Colors.white;
  static double borderRadius = 20;

  @override
  Widget build(BuildContext context) {
    final financeProvider = Provider.of<FinanceProvider>(context);

    return Container(
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
                Text(
                  'Egresos fijos',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                CustomAddButton(),
                SizedBox(height: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 300, minHeight: 0),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CustomExpenses(
                        itemId: index,
                        itemText: financeProvider.expenses[index].name,
                        monthText: financeProvider.expenses[index].month,
                        mountText: financeProvider.expenses[index].amount,
                      );
                    },
                    itemCount: financeProvider.expenses.length,
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

class CustomAddButton extends StatelessWidget {
  const CustomAddButton({super.key});

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
        showExpensesForm(context, financeProvider);
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

class CustomExpenses extends StatefulWidget {
  const CustomExpenses({
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
  State<CustomExpenses> createState() => _CustomExpensesState();
}

class _CustomExpensesState extends State<CustomExpenses> {
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
                    financeProvider.removeExpense(widget.itemId);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: CustomExpenses.buttonColor,
                      borderRadius: BorderRadius.circular(
                        CustomExpenses.borderRadius,
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
                        color: CustomExpenses.textColor,
                        height: 1.0,
                      ),
                    ),
                    Text(
                      widget.monthText,
                      style: TextStyle(
                        fontSize: 15,
                        color: CustomExpenses.secondTextColor,
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
                color: CustomExpenses.textColor,
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

void showExpensesForm(BuildContext context, FinanceProvider financeProvider) {
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

              financeProvider.addExpense = nuevoGasto;

              Navigator.pop(context);
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    ),
  );
}
