import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masroufi/ExpenseCard.dart';
import 'expense.dart';

class EXListWidget extends StatelessWidget {
  List<expense> allExpenses;
  Function deleteExpense;
  EXListWidget({required this.allExpenses, required this.deleteExpense});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,

        child: ListView.builder(
          itemCount: allExpenses.length,
          itemBuilder: (context, index) {
            return ExpenseCard(allExpenses: allExpenses, deleteExpense: deleteExpense, index: index) ;
          },
        ));
  }
}
