import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat(Intl.defaultLocale);

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

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

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: _titleController,
            enableSuggestions: true,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Title")),
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
                  decoration: const InputDecoration(
                      label: Text("Amount"), prefixText: "£ "),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? "Please Select a Date"
                        : formatter.format(_selectedDate!)),
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
                value: _selectedCategory,
                items: Category.values
                    .map((catergory) => DropdownMenuItem(
                        value: catergory,
                        child: Text(catergory.name.toString().toUpperCase())))
                    .toList(),
                onChanged: (value) {
                  if(value == null){
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              ),
              const Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                print("Title: " + _titleController.text);
                print("Amount: " + _amountController.text);
                print("Category: " + _selectedCategory.name.toString());
                if(_selectedDate == null) {
                  return;
                }
                print("Date: " + formatter.format(_selectedDate!));
              },
              child: const Text('Save Expense'),
            ),
          ])
        ]));
  }
}
