import 'package:uuid/uuid.dart';

const uuid = Uuid();
enum Category {food, leisure, travel, work}

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
}
