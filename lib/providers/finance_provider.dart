import 'package:finances/models/expenses_model.dart';
import 'package:flutter/material.dart';

class FinanceProvider extends ChangeNotifier {
  // double _balance = 900;
  // double _expensesTotal = 380;
  // double _grossTotal = 520;
  // double _percentage = 0.1;
  // double _saving = 52;
  double _balance = 0;
  final List<ExpensesModel> _expenses = [];
  double _expensesTotal = 0;
  double _grossTotal = 0;
  double _percentage = 0.2;
  double _saving = 0;
  double _free = 0;

  double get balance => _balance;
  set balance(double newBalance) {
    _balance = newBalance;
    setGrossAndSaving();
    notifyListeners();
  }

  List<ExpensesModel> get expenses => _expenses;
  set addExpense(ExpensesModel expense) {
    _expenses.add(expense);
    _expensesTotal += expense.amount;
    setGrossAndSaving();
    notifyListeners();
  }

  void removeExpense(int index) {
    _expensesTotal -= _expenses[index].amount;
    _expenses.removeAt(index);
    setGrossAndSaving();
    notifyListeners();
  }

  double get expensesTotal => _expensesTotal;

  double get grossTotal => _grossTotal;
  void setGrossAndSaving() {
    if (_balance > 0) {
      _grossTotal = _balance - _expensesTotal;
      _saving = _grossTotal * _percentage;
      _free = _grossTotal - _saving;
    }
  }

  double get saving => _saving;
  void actSaving() {
    if (_balance > 0) {
      _saving = _grossTotal * _percentage;
    }
  }

  double get percentage => _percentage;

  set percentage(double newPercentage) {
    _percentage = newPercentage / 100;
    actSaving();
    notifyListeners();
  }

  double get free => _free;
}
