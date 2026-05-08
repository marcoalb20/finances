import 'package:finances/models/expenses_model.dart';
import 'package:flutter/material.dart';

class FinanceProvider extends ChangeNotifier {
  double _balance = 1200.0;
  List<ExpensesModel> _expenses = [
    ExpensesModel(name: 'CASA', month: "01/05/2026", amount: 300),
    ExpensesModel(name: 'INTERNET', month: "06/05/2026", amount: 80),
  ];

  double get balance => _balance;
  set balance(double newBalance) {
    _balance = newBalance;
    notifyListeners();
  }

  List<ExpensesModel> get expenses => _expenses;
  set addExpense(ExpensesModel expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void removeExpense(int index) {
    _expenses.removeAt(index);
    notifyListeners();
  }
}
