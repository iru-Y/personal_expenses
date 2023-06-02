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
        buttonTheme: const ButtonThemeData(
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

 bool _showChart = false;

  final List<Transaction>_transactions = [
    Transaction("t1", "Novo tênis de corrida", 310.75, DateTime.now()),
    Transaction("t2", "Conta de luz", 6787.56, DateTime.now()),
    Transaction("t3", "Conta 03", 3230.75, DateTime.now()),
    Transaction("t4", "Conta 05", 1430.56, DateTime.now()),
    Transaction("t5", "Conta 07", 150.76, DateTime.now()),
    Transaction("t6", "Conta 08", 160.26, DateTime.now()),
    Transaction("t7", "Conta 12", 1420.27, DateTime.now()),
    Transaction("t8", "Conta 55", 1410.13, DateTime.now()),
  ];

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Exibir gráficos"),
                Switch(value: _showChart,
                    onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                }),
              ],
            ),
            if(_showChart)
            Chart(_recentTransactions),
            if(!_showChart)
            TransactionalList(_transactions, _removeTransaction),
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
