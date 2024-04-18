import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('dd/MM/yyyy');

const uuid = Uuid();

enum Category { food, leisure, travel, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.strTitle,
    required this.dAmount,
    required this.date,
    required this.enumCategory,
  }) : strId = uuid.v4();

  final String strId;
  final String strTitle;
  final double dAmount;
  final DateTime date;
  final Category enumCategory;

  String get formattedDate {
    return formatter.format(date);
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      strTitle: json['strTitle'],
      dAmount: json['dAmount'],
      date: DateTime.parse(json['date']),
      enumCategory: Category.values[json['enumCategory']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'strTitle': strTitle,
      'dAmount': dAmount,
      'date': date.toIso8601String(),
      'enumCategory': enumCategory.index,
    };
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.enumCategory == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double intSum = 0;

    for (final expense in expenses) {
      intSum += expense.dAmount;
    }
    return intSum;
  }
}
