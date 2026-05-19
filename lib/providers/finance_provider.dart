import 'dart:convert';
import 'package:finances/models/expenses_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinanceProvider extends ChangeNotifier {
  double _balance = 0;
  final List<ExpensesModel> _expenses = [];
  final List<ExpensesModel> _expensesPers = [];
  double _expensesTotal = 0;
  double _freePers = 0;
  double _grossTotal = 0;
  double _percentage = 0.2;
  double _percentageExpense = 0;
  double _saving = 0;
  double _free = 0;
  String _user = 'Usuario';

  // Keys
  static const _kBalance = 'finance_balance';
  static const _kPercentage = 'finance_percentage';
  static const _kExpenses = 'finance_expenses';
  static const _kExpensesPers = 'finance_expenses_pers';
  static const _kUser = 'finance_user';

  Future<void> loadFormPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    _balance = prefs.getDouble(_kBalance) ?? 0;
    _percentage = prefs.getDouble(_kPercentage) ?? 0;
    _user = prefs.getString(_kUser) ?? 'Usuario';

    final expensesJson = prefs.getStringList(_kExpenses) ?? [];
    _expenses.clear();
    _expensesTotal = 0;
    for (final item in expensesJson) {
      final e = ExpensesModel.fromJson(jsonDecode(item));
      _expenses.add(e);
      _expensesTotal += e.amount;
    }

    final expensesPersJson = prefs.getStringList(_kExpensesPers) ?? [];
    _expensesPers.clear();
    for (final item in expensesPersJson) {
      _expensesPers.add(ExpensesModel.fromJson(jsonDecode(item)));
    }

    setGrossAndSaving();

    for (final e in _expensesPers) {
      _freePers -= e.amount;
    }

    actPercentageExpense();
    notifyListeners();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_kBalance, _balance);
      await prefs.setDouble(_kPercentage, _percentage);
      await prefs.setString(_kUser, _user);
      await prefs.setStringList(
        _kExpenses,
        _expenses.map((e) => jsonEncode(e.toJson())).toList(),
      );
      await prefs.setStringList(
        _kExpensesPers,
        _expensesPers.map((e) => jsonEncode(e.toJson())).toList(),
      );
      print('Guardado: balance=$_balance, expenses=${_expenses.length}');
    } catch (e) {
      print('Error al guardar: $e');
    }
  }

  double get balance => _balance;
  set balance(double newBalance) {
    _balance = newBalance;
    // debugPrefs();
    setGrossAndSaving();
    _save();
    notifyListeners();
  }

  List<ExpensesModel> get expenses => _expenses;

  set addExpense(ExpensesModel expense) {
    _expenses.add(expense);
    _expensesTotal += expense.amount;
    setGrossAndSaving();
    _save();
    notifyListeners();
  }

  List<ExpensesModel> get expensesPers => _expensesPers;
  set addExpensePers(ExpensesModel expense) {
    _expensesPers.add(expense);
    _freePers -= expense.amount;
    actPercentageExpense();
    _save();
    notifyListeners();
  }

  void removeExpense(int index) {
    _expensesTotal -= _expenses[index].amount;
    _expenses.removeAt(index);
    setGrossAndSaving();
    _save();
    notifyListeners();
  }

  void removeExpensePers(int index) {
    _freePers += _expensesPers[index].amount;
    _expensesPers.removeAt(index);
    actPercentageExpense();
    _save();
    notifyListeners();
  }

  double get expensesTotal => _expensesTotal;

  double get grossTotal => _grossTotal;
  void setGrossAndSaving() {
    if (_balance > 0) {
      _grossTotal = _balance - _expensesTotal;
      _saving = _grossTotal * _percentage;
      _free = _grossTotal - _saving;
      _freePers = _free;
      actPercentageExpense();
    }
  }

  void actPercentageExpense() {
    _percentageExpense = 100 - ((_freePers / free) * 100);
  }

  double get saving => _saving;
  void actSaving() {
    if (_balance > 0) {
      _saving = _grossTotal * _percentage;
      _free = _grossTotal - _saving;
      _freePers = _free;
    }
  }

  double get percentage => _percentage;
  double get percentageExpense => _percentageExpense;

  set percentage(double newPercentage) {
    _percentage = newPercentage / 100;
    actSaving();
    _save();
    notifyListeners();
  }

  double get free => _free;
  double get freePers => _freePers;

  String get user => _user;
  set user(String newUser) {
    // .toUpperCase()}${clean.substring(1).toLowerCase()
    // ${clean[0].toUpperCase()}${clean.substring(1).toLowerCase()}
    if (newUser.isNotEmpty) {
      _user =
          '${newUser[0].toUpperCase()}${newUser.substring(1).toLowerCase()}';
    }
    _save();
    notifyListeners();
  }
}
