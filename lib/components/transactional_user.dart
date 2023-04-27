import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personal_expenses/components/transactional_list.dart';
import 'transactional_form.dart';
import '../models/transaction.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction("t1", "Novo tênis de corrida", 310.75, DateTime.now()),
    Transaction("t2", "Conta de luz", 6787.56, DateTime.now()),
    Transaction("t3", "Conta 03", 3230.75, DateTime.now()),
    Transaction("t4", "Conta 05", 1430.56, DateTime.now()),
    Transaction("t5", "Conta 07", 150.76, DateTime.now()),
    Transaction("t6", "Conta 08", 160.26, DateTime.now()),
    Transaction("t7", "Conta 12", 1420.27, DateTime.now()),
    Transaction("t8", "Conta 55", 1410.13, DateTime.now()),
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

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(_addTransaction),
        TransactionalList(_transactions)
      ],
    );
  }
}
