import 'dart:io';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum NewExpenseErrorContext { date, amount, title }

final formatter = DateFormat('dd/MM/yyyy');

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  DateTime? _selectedDate;

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final dtNow = DateTime.now();
    final dtFirstDate = DateTime(dtNow.year - 1, dtNow.month, dtNow.day);
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: dtFirstDate,
        lastDate: dtNow);
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void _submitExpenseData() {
    final dEnteredAmount = double.tryParse(_amountController.text);
    final bAmountIsInValid = dEnteredAmount == null || dEnteredAmount <= 0;
    if (bAmountIsInValid) {
      _displayError(NewExpenseErrorContext.amount);
      return;
    }
    if (_titleController.text.trim().isEmpty) {
      _displayError(NewExpenseErrorContext.title);
      return;
    }
    if (_selectedDate == null) {
      _displayError(NewExpenseErrorContext.date);
      return;
    }
    widget.onAddExpense(Expense(
        strTitle: _titleController.text,
        dAmount: dEnteredAmount,
        date: _selectedDate!,
        enumCategory: _selectedCategory));
    Navigator.pop(context);
  }

  void _displayError(NewExpenseErrorContext enumContext) {
    String strTitle = "An unhandled error occured";
    String strBody = "An error occured in submitting inputs";

    switch (enumContext) {
      case NewExpenseErrorContext.amount:
        strTitle = "Invalid amount submitted";
        strBody = "Please input a number that is greater than 0";
        break;
      case NewExpenseErrorContext.date:
        strTitle = "No date submitted";
        strBody = "Please input the date of the expense";
        break;
      case NewExpenseErrorContext.title:
        strTitle = "No title submitted";
        strBody = "Please input the name of the expense";
        break;
      default:
    }
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context, 
        builder: (ctx) => CupertinoAlertDialog(
            title: Text(strTitle),
            content: Text(strBody),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("Okay"))
            ],
          ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(strTitle),
          content: Text(strBody),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text("Okay"))
          ],
        ),
      );
    }
    return;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: double.infinity,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        width: double.infinity,
        child: SingleChildScrollView(
          clipBehavior: Clip.hardEdge,
          child: Container(
            width: width,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background),
                // borderRadius: BorderRadius.circular(50)),
            child: Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, keyboardSpace + 16),
                child: Column(children: [
                  TextField(
                    controller: _titleController,
                    enableSuggestions: true,
                    maxLength: 50,
                    decoration: InputDecoration(
                        label: Text("Title:",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .color)),
                        helperStyle: TextStyle(
                            color:
                                Theme.of(context).textTheme.labelMedium!.color)),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          maxLength: 50,
                          decoration: InputDecoration(
                              label: Text("Amount:",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .color)),
                              helperStyle: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .color),
                              prefixText: "£ "),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? "Please Select a Date"
                                  : formatter.format(_selectedDate!),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month))
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(children: [
                    DropdownButton(
                        style: Theme.of(context).textTheme.labelMedium,
                        value: _selectedCategory,
                        items: Category.values
                            .map((catergory) => DropdownMenuItem(
                                value: catergory,
                                child: Text(
                                    catergory.name.toString().toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        }),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .color))),
                    ElevatedButton(
                      onPressed: () {
                        _submitExpenseData();
                      },
                      child: const Text(
                        'Save Expense',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ])
                ])),
          ),
        ),
      ),
    );
  }
}
