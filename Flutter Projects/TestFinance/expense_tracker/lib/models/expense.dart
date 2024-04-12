import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat(Intl.defaultLocale);

const uuid = Uuid();
enum Category {food, leisure, travel, work}

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

  String get formattedDate{
    return formatter.format(date);
  }
}
