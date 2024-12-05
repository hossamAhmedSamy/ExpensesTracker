import 'package:expense_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Categorys.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Categorys.leisure,
    ),
  ];

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(expense.title + " expense removed"),
      duration: Duration(seconds: 4),
      action: SnackBarAction(
        label: 'undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.add(expense);
          });
        },
      ),
    ));
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: addExpense,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No expenses found. Start adding some!"),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = Expanded(
        child: ExpensesList(
          expenses: _registeredExpenses,
          onRemoveExpense: removeExpense,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter ExpenseTracker",
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text(
            "The Chart",
          ),
          mainContent,
        ],
      ),
    );
  }
}
