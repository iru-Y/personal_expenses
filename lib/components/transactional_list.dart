import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionalList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionalList(this.transactions, {Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tr = transactions[index];
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "R\$ ${tr.value.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tr.title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateFormat("d MM y").format(tr.date),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
