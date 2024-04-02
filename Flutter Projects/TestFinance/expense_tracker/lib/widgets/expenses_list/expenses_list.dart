import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.listExpenses});

  final List<Expense> listExpenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listExpenses.length,
      itemBuilder: (ctx, index) => Text(listExpenses[index].strTitle),
    );
  }
}
