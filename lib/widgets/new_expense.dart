import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final Function(Expense) onAddExpense; // Callback function

  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  Categorys _selectedCategory = Categorys.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enterAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enterAmount == null || enterAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _dateController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date, and category are entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    } else {
      final newExpense = Expense(
        title: _titleController.text,
        amount: enterAmount,
        date: DateFormat('yyyy-MM-dd').parse(_dateController.text),
        category: _selectedCategory,
      );

      widget.onAddExpense(newExpense);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            maxLength: 20,
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text("Enter expense Title"),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: _amountController,
            decoration: const InputDecoration(
              label: Text('Enter amount'),
              prefix: Text('\$'),
            ),
          ),
          TextField(
            controller: _dateController,
            decoration: InputDecoration(
              label: const Text('Enter Date'),
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                  }
                },
              ),
            ),
            readOnly: true,
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButton<Categorys>(
                  value: _selectedCategory,
                  items: Categorys.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
