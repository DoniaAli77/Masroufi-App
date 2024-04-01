import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class ExpenseForm extends StatefulWidget {
  Function addnew;
  ExpenseForm({required this.addnew});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  bool showTotal = true;

  var title = TextEditingController();
  var amount = TextEditingController();
  DateTime seDate = DateTime.utc(1970, 1, 1);
  void opencalender() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.utc(2024, 12, 30))
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        seDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'ex title'),
              controller: title,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'amount'),
              controller: amount,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(seDate == DateTime.utc(1970, 1, 1)
                        ? 'no choosen Date'
                        : DateFormat.yMd().format(seDate))),
                TextButton(
                    onPressed: () {
                      opencalender();
                    },
                    child: Text('choose date'))
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  widget.addnew(
                      t: title.text, a: double.parse(amount.text), d: seDate);
                  title.clear();
                  amount.clear();
                },
                child: Text('submit'))
          ],
        ),
      ),
    );
  }
}
//------------------(hook version still under testing how to pass context )-----------------

// class NewExWidgetHook extends HookWidget {
//   Function addnew;
//   NewExWidgetHook({required this.addnew});
//   @override
//   Widget build(BuildContext context) {

//     var title = useTextEditingController();
//     var amount = useTextEditingController();
//     ValueNotifier<DateTime> seDate = useState(DateTime.utc(1970, 1, 1));
//     // DateTime seDate = DateTime.utc(1970, 1, 1);
//     void opencalender() {
//       showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime.now(),
//               lastDate: DateTime.utc(2024, 12, 30))
//           .then((pickedDate) {
//         if (pickedDate == null) return;

//         seDate.value = pickedDate;
//       });
//     }

//     return SingleChildScrollView(
//       child: Container(
//         margin: EdgeInsets.only(
//             left: 10,
//             right: 10,
//             bottom: MediaQuery.of(context).viewInsets.bottom + 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             TextField(
//               decoration: InputDecoration(labelText: 'ex title'),
//               controller: title,
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'amount'),
//               controller: amount,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                     child: Text(seDate.value == DateTime.utc(1970, 1, 1)
//                         ? 'no choosen Date'
//                         : DateFormat.yMd().format(seDate.value))),
//                 TextButton(
//                     onPressed: () {
//                       opencalender();
//                     },
//                     child: Text('choose date'))
//               ],
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   addnew(
//                       t: title.value, a: double.parse(amount.value as String), d: seDate,mycontext:context);
//                   title.clear();
//                   amount.clear();
//                 },
//                 child: Text('submit'))
//           ],
//         ),
//       ),
//     );
//   }
// }
