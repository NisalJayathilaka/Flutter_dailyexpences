import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _tittleController = TextEditingController();
  final _amountController = TextEditingController();
   DateTime ?_selectedDate;

  void submiteddata() {
    if(_amountController.text.isEmpty)
    {
      return;
    }
    final enteredTitle = _tittleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if(pickedDate == null)
      {
        return;
      }
      setState(() {
        _selectedDate =pickedDate;
      });
      
    });
    print('object');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10.0,
        child: Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom+5.0,top: 10.0,left:10.0,right:10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
                controller: _tittleController,
                onSubmitted: (_) => submiteddata(),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Amount',
                ),
                controller: _amountController,
                onSubmitted: (_) => submiteddata(),
              ),
              Container(
                height: 70.0,
                child: Row(
                  children: [
                    
                    Expanded(child: Text(_selectedDate == null ? 'No date Chosen':'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}')),
                    FlatButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          'Chose Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        textColor: Theme.of(context).primaryColorDark)
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  submiteddata();
                },
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button?.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


