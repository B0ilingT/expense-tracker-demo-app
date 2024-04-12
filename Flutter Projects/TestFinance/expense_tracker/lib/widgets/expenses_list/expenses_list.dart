import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.listExpenses, required this.onRemoveExpense});

  final List<Expense> listExpenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listExpenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(listExpenses[index]),
        onDismissed:(direction) {
          onRemoveExpense(listExpenses[index]);
        },
        child: ExpenseItem(listExpenses[index]),
      ),
    );
  }
}
