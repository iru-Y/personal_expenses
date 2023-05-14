import 'dart:math';

import 'package:flutter/material.dart';
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

  final List<Transaction>_transactions = [
    // Transaction("t1", "Novo tênis de corrida", 310.75, DateTime.now()),
    // Transaction("t2", "Conta de luz", 6787.56, DateTime.now()),
    // Transaction("t3", "Conta 03", 3230.75, DateTime.now()),
    // Transaction("t4", "Conta 05", 1430.56, DateTime.now()),
    // Transaction("t5", "Conta 07", 150.76, DateTime.now()),
    // Transaction("t6", "Conta 08", 160.26, DateTime.now()),
    // Transaction("t7", "Conta 12", 1420.27, DateTime.now()),
    // Transaction("t8", "Conta 55", 1410.13, DateTime.now()),
  ];

  _addTransaction(String title, double value){
    final newTransaction = Transaction(
        Random().nextDouble().toString(),
        title,
        value,
        DateTime.now()
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
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
                // ignore: avoid_unnecessary_containers
                const SizedBox(
                  child: Card(
                   color: Colors.black,
                   elevation: 5,
                   child: Text("Gráfico",
                       style: TextStyle(color: Colors.white)),
                             ),
                ),
        Column(
          children: [
            TransactionalList(_transactions)
          ],
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
