import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            children: [
              Text(expense.strTitle),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text('\£${expense.dAmount.toStringAsFixed(2)}'),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[expense.enumCategory]),
                      const SizedBox(width:8),
                      Text(expense.formattedDate),
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }
}
