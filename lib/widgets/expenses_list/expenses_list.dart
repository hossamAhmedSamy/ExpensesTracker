import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required  this.onRemoveExpense ,
  });
  final List<Expense> expenses;
  final void Function(Expense expense)  onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index].id),
        onDismissed: (direction){onRemoveExpense(expenses[index]);},
        child: ExpenseItem(
          expense: expenses[index],
        ),
      ),
      itemCount: expenses.length,
    );
  }
}