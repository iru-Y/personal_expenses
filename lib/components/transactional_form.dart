import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate;
  

  _submitForm(){
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0 || _selectedDate == null){
        return;
    }
      widget.onSubmit(title, value, _selectedDate!);
  }

  _showDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate == null){
        return;
      }

    setState(() {
      _selectedDate = pickedDate;
    });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  onSubmitted: (_)=> _submitForm(),
                  decoration: const InputDecoration(labelText: "Título"),
                ),
                TextField(
                  controller: _valueController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_)=> _submitForm(),
                  decoration: const InputDecoration(labelText: "Valor (R\$)"),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(_selectedDate == null? "Nenhuma data selecionada"
                        : "Data selecionada: ${DateFormat("dd/MM/y").format(_selectedDate!)}"),
                      ),
                      TextButton(
                          child: Text("Selecione uma data"),
                        onPressed: _showDatePicker,
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: ()=> _submitForm,
                        child: Text(
                          "Nova transação",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                )
              ],
            )));
  }
}
