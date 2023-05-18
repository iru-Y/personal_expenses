import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personal_expenses/components/chart.dart';
import 'package:personal_expenses/components/transactional_form.dart';
import 'package:flutter/rendering.dart';
import 'components/transactional_list.dart';
import 'models/transaction.dart';

void main(){
  debugPaintSizeEnabled= true;
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHome(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: "Schuyler",
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
        )
        )
      );
  }
}

class MyHome extends StatefulWidget {

  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  final List<Transaction>_transactions = [];

  List<Transaction> get _recentTransactions{
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
          const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime time){
    final newTransaction = Transaction(
        Random().nextDouble().toString(),
        title,
        value,
        time
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _removeTransaction(String id){
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (_){
          return TransactionForm(_addTransaction);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas pessoais"),
        actions: <Widget>[
          IconButton(onPressed:()=> _openTransactionFormModal(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            Container(
              child: TransactionalList(_transactions, _removeTransaction)
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed:()=> _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
