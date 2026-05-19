class ExpensesModel {
  late String name;
  late String month;
  late double amount;

  static String _capitalize(String text) {
    if (text.trim().isEmpty) return text;
    String clean = text.trim();
    return '${clean[0].toUpperCase()}${clean.substring(1).toLowerCase()}';
  }

  ExpensesModel({
    required String name,
    required String month,
    required this.amount,
  }) : name = _capitalize(name),
       month = _capitalize(month);

  String get nameExpense => name;
  set nameExpense(String newName) {
    name = newName;
  }

  String get monthExpense => month;
  set monthExpense(String newMonth) {
    month = newMonth;
  }

  double get amountExpense => amount;
  set amountExpense(double newAmount) {
    amount = newAmount;
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'month': month,
    'amount': amount,
  };

  factory ExpensesModel.fromJson(Map<String, dynamic> json) => ExpensesModel(
    name: json['name'] as String,
    month: json['month'] as String,
    amount: (json['amount'] as num).toDouble(),
  );
}
