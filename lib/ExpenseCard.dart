import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'expense.dart';


class ExpenseCard extends StatelessWidget {
  List<expense> allExpenses;
  Function deleteExpense;
  int index;
   ExpenseCard({required this.allExpenses, required this.deleteExpense,required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
            margin: EdgeInsets.all(10),
                elevation: 5,
                child: Row(
                  children: [
// 1st child of the row is the amount
                    Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          allExpenses[index].amount.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
// 2nd child of the row is a colum containing children itself.
                    ,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // col child 1 is title
                        Text(allExpenses[index].title,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
//col child 2 is the date
                        Text(
                            DateFormat('dd-MM-yyyy')
                                .format(allExpenses[index].date),
                            style: TextStyle(color: Colors.grey))
                      ],
                    )),

// third child
                    Container(
                      child: IconButton(
                          onPressed: () {deleteExpense(index);},
                          icon: Icon(Icons.delete),
                          color: Colors.red),
                    ),
                  ],
                ));
  }
}