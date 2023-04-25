import 'package:flutter/material.dart';

import 'components/transactional_user.dart';

main() => runApp(const ExpenseApp());

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {


  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas pessoais"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const <Widget>[
                // ignore: avoid_unnecessary_containers
                SizedBox(
                  child: Card(
                   color: Colors.black,
                   elevation: 5,
                   child: Text("Gráfico", style: TextStyle(color: Colors.white)),
                             ),
                ),
             TransactionUser()
          ],
        ),
      ),
    );
  }
}
