import 'dart:convert';

import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
   final List<Expense> _registeredExpenses = [];
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final String? expenseDataString = await _storage.read(key: 'expenses');
    if (expenseDataString != null) {
      final List<Map<String, dynamic>> expenseData = jsonDecode(expenseDataString).cast<Map<String, dynamic>>();
      setState(() {
        _registeredExpenses.clear();
        _registeredExpenses.addAll(
          expenseData.map((data) => Expense.fromJson(data)),
        );
      });
    }
  }

  Future<void> _saveExpenses() async {
    final List<Map<String, dynamic>> expenseData = _registeredExpenses.map((expense) => expense.toJson()).toList();
    final String expenseDataString = jsonEncode(expenseData);
    await _storage.write(key: 'expenses', value: expenseDataString);
  }


  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
      isScrollControlled: true,
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
    _saveExpenses();
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Expense Deleted"),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            })));
    _saveExpenses();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool isPortrait = true;

    if (width > height) {isPortrait = false;}

    Widget mainContent = const Center(
        child: Text("No expenses found, spend some bloody money!"));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          listExpenses: _registeredExpenses, onRemoveExpense: _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Expense Tracker"),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
        shadowColor: Theme.of(context).canvasColor,
        surfaceTintColor: Theme.of(context).secondaryHeaderColor,
      ),
      body: isPortrait ? Column(children: [
        Container(
            margin: const EdgeInsets.fromLTRB(16, 24, 16, 32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).cardTheme.color,
            ),
            child: Chart(expenses: _registeredExpenses)),
        Expanded(
          child: mainContent,
        ),
      ]) : Row(
        crossAxisAlignment: CrossAxisAlignment.start,       
        children: [
        Expanded(
          child: Container(    
              margin: Theme.of(context).cardTheme.margin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).cardTheme.color,
              ),
              child: Chart(expenses: _registeredExpenses)),
        ),
        Expanded(
          child: mainContent,
        ),
      ]),
    );
  }
}
