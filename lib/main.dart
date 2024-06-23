import 'package:flutter/material.dart';
import 'ExlistWidget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'NewExWidget.dart';
import 'expense.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masroufi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: mainPage(),   //mainPageHook(),
    );
  }
}

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  final List<expense> allExpenses = [];
  void addnewExpense(
      {required String t, required double a, required DateTime d}) {
    setState(() {
      allExpenses.add(
          expense(amount: a, date: d, id: DateTime.now().toString(), title: t));
    });
    Navigator.of(context).pop();
  }

  void deleteExpense({required String id}) {
    setState(() {
      allExpenses.removeWhere((e) {
        return e.id == id;
      });
    });
  }

  double calculateTotal() {
    double total = 0;
    allExpenses.forEach((e) {
      total += e.amount;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (b) {
                return ExpenseForm(addnew: addnewExpense);//ExpenseFormHook(addnew: addnewExpense)
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (b) {
                      return ExpenseForm(addnew: addnewExpense);
                    });
              },
              icon: Icon(Icons.add))
        ],
        title: Text('Masroufi'),
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            height: 100,
            child: Card(
              elevation: 5,
              child: Center(
                  child: Text(
                'EGP ' + calculateTotal().toString(),
                style: TextStyle(fontSize: 30),
              )),
            ),
          ),
          EXListWidget(allExpenses: allExpenses, deleteExpense: deleteExpense),
        ],
      ),
    );
  }
}
//-----------------------(Hook version)-----------------------------
class mainPageHook extends HookWidget {
  @override
  Widget build(BuildContext context) {
final ValueNotifier<List<expense>> allExpenses = useState<List<expense>>([]);
    void addnewExpense(
        {required String t, required double a, required DateTime d}) {
      allExpenses.value = [
        ...allExpenses.value,
        expense(amount: a, date: d, id: DateTime.now().toString(), title: t)
      ];

      Navigator.of(context).pop();
    }

    void deleteExpense({required String id}) {
      allExpenses.value = [
        ...?(allExpenses.value as List<expense>)
          ..removeWhere((e) {
            return e.id == id;
          })
      ];
    }

    double calculateTotal() {
      double total = 0;
      allExpenses.value.forEach((e) {
        total += e.amount;
      });
      return total;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (b) {
                return ExpenseForm(addnew: addnewExpense);
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (b) {
                      return ExpenseForm(addnew: addnewExpense); //ExpenseFormHook(addnew: addnewExpense)
                    });
              },
              icon: Icon(Icons.add))
        ],
        title: Text('Masroufi'),
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            height: 100,
            child: Card(
              elevation: 5,
              child: Center(
                  child: Text(
                'EGP ' + calculateTotal().toString(),
                style: TextStyle(fontSize: 30),
              )),
            ),
          ),
          EXListWidget(
              allExpenses: allExpenses.value as List<expense>,
              deleteExpense: deleteExpense),
        ],
      ),
    );
  }
}
