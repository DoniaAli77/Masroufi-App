import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ExlistWidget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'NewExWidget.dart';
import 'expense.dart';

void main() {
  /* to force portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
 */

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: mainPage(),
    );
  }
}

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  bool showTotal = true;
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
                      return ExpenseForm(addnew: addnewExpense);
                    });
              },
              icon: Icon(Icons.add))
        ],
        title: Text('Masroufi'),
      ),
      body: ListView(
        children: [
          if (MediaQuery.of(context).orientation ==
              Orientation.landscape) //////orientation
            Switch.adaptive(
                // to make switch adape to platfrom
                value: showTotal,
                onChanged: (value) {
                  setState(() {
                    showTotal = value;
                  });
                }),
          if (showTotal)
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

//-----------------------(platform version)-------------------------

class mainPagePlatfrom extends StatefulWidget {
  const mainPagePlatfrom({super.key});

  @override
  State<mainPagePlatfrom> createState() => _mainPagePlatfromState();
}

class _mainPagePlatfromState extends State<mainPagePlatfrom> {
  bool showTotal = true;
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
    final Widget body = ListView(
      children: [
        if (MediaQuery.of(context).orientation ==
            Orientation.landscape) //////orientation
          Switch.adaptive(
              // to make switch adape to platfrom
              value: showTotal,
              onChanged: (value) {
                setState(() {
                  showTotal = value;
                });
              }),
        if (showTotal)
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
    );

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Masroufi IOS',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (b) {
                          return ExpenseForm(addnew: addnewExpense);
                        });
                  },
                ),
              ],
            ),
          ) as ObstructingPreferredSizeWidget
        : AppBar(
            title: Text(
              'Masroufi Android',
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (b) {
                          return ExpenseForm(addnew: addnewExpense);
                        });
                  }),
            ],
          );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: body,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
          );
  }
}

//-----------------------(Hook version)-----------------------------
class mainPageHook extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<List<expense>> allExpenses =
        useState<List<expense>>([]);
    var context = useContext();
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
          EXListWidget(
              allExpenses: allExpenses.value as List<expense>,
              deleteExpense: deleteExpense),
        ],
      ),
    );
  }
}
