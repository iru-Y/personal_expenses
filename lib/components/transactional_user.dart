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
    Transaction("t2", "Conta de luz", 110.56, DateTime.now()),
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
        TransactionalList(_transactions),
        TransactionForm(_addTransaction)
      ],
    );
  }
}
