//
// import 'package:expense_tracker/models/expense.dart';
// import 'package:expense_tracker/widgets/expenses_list.dart';
// import 'package:expense_tracker/widgets/new_expense.dart';
// import 'package:flutter/material.dart';
//
// class Expenses extends StatefulWidget {
//   const Expenses({super.key});
//
//
//   @override
//   State<Expenses> createState(){
//      return _ExpenseState();
//   }
// }
// class _ExpenseState extends State<Expenses> {
//   final List<Expense> _registeredExpenses = [
//     Expense(
//       title: 'Flutter Course',
//       amount: 19.99,
//       date: DateTime.now(),
//       category: Category.work,
//     ),
//     Expense(
//       title: 'Cinema',
//       amount: 15.99,
//       date: DateTime.now(),
//       category: Category.leisure,
//     ),
//   ];
//
//   void _openAddExpenseOverlay() {
//     showModalBottomSheet(
//         isScrollControlled: true, /* for Full screen*/
//         context: context,
//         builder: (ctx) => NewExpense(onAddExpense: _addExpense));
//   }
//
//   // adding new expense and save
//   void _addExpense(Expense expense) {
//     setState(() {
//       _registeredExpenses.add(expense);
//     });
//   }
//
//   // for removing the expense
//   void _removeExpense(Expense expense) {
//     final expenseIndex = _registeredExpenses.indexOf(expense);
//     setState(() {
//       _registeredExpenses.remove(expense);
//     });
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//        SnackBar(
//         duration:const  Duration(seconds: 3),
//         content: const Text('Expense Deleted'),
//         action: SnackBarAction(label: 'Undo',
//           onPressed: () {
//             setState(() {
//               _registeredExpenses.insert(expenseIndex,expense);
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//    //  iska use message print ke liye jab koi data na ho
//     Widget mainContent = const Center(
//       child: Text('No Expenses Found , Start Adding Some'),
//     );
//
//     if(_registeredExpenses.isNotEmpty){
//       mainContent=ExpensesList(
//         expenses: _registeredExpenses,
//         onRemoveExpense: _removeExpense,
//       );
//     }
// }
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});


  @override
  State<Expenses> createState(){
    return _ExpenseState();
  }
}
class _ExpenseState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Room Rent',
      amount: 4000.00,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Vegetable',
      amount: 500.00,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      /*Safe area*/
      useSafeArea: true,/*It is the feature to avoid camera area*/
        isScrollControlled: true, /* for Full screen*/
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  // adding new expense and save
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // for removing the expense
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration:const  Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex,expense);
            });
          },
        ),
      ),
    );
  }

@override
Widget build(BuildContext context) {
    /*Now these code are used for responsiveness to know how
    * much with we have available*/
  final width =  (MediaQuery.of(context).size.width);
  print (MediaQuery.of(context).size.width);
  print (MediaQuery.of(context).size.height);


  //  iska use message print ke liye jab koi data na ho
  Widget mainContent = const Center(
    child: Text('No Expenses Found , Start Adding Some'),
  );

  if(_registeredExpenses.isNotEmpty){
    mainContent=ExpensesList(
      expenses: _registeredExpenses,
      onRemoveExpense: _removeExpense,
    );
  }

  return   Scaffold(
    appBar: AppBar (
      title: const Text('Expenses Tracker'),
      backgroundColor: Colors.blueAccent,
      actions: [
        IconButton(
          onPressed: _openAddExpenseOverlay,
          icon: const Icon(Icons.add),
        ),
      ],
    ),

    body:/*for width condition */ width <600 ? Column(
      children: [
        // Toolbar with the Add button  here => Row
       /* Chart(expenses: _registeredExpenses),*/
        const Text('Expenses List'),
        Expanded(
          child:mainContent,
        ),
      ],
    )
        :/*iska use to change for row*/ Row(children: [
      const Text('Expenses List'),
      Expanded(
        child:mainContent,
      ),
    ],)
  );
}
}