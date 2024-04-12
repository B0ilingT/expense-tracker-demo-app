import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

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
          TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
            maxLength: 50,
            decoration:
                const InputDecoration(label: Text("Amount"), prefixText: "£ "),
          ),
          Row(children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            ElevatedButton(
              onPressed: () {
                print("Title: " + _titleController.text);
                print("Amount: " + _amountController.text);
              },
              child: const Text('Save Expense'),
            ),
          ])
        ]));
  }
}
