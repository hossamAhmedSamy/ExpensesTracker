import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();


enum Categorys {food , traverl ,leisure , work}
const categoryIcons = {
  Categorys.food: Icons.lunch_dining,
  Categorys.traverl: Icons.flight_takeoff,
  Categorys.leisure: Icons.movie,
  Categorys.work: Icons.work,
};
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = const Uuid().v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categorys category;
  String get formattedDate {
    return DateFormat.yMd().format(date);
  }
}
