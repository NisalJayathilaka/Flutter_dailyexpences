import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transation;
  final Function deleteTranceAction;
  TransactionsList(this.transation,this.deleteTranceAction);

  @override
  Widget build(BuildContext context) {
    return transation.isEmpty
        ? Column(
            children: [
              Text(
                'No transcation there',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 20.0),
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Image.asset(
                  'assets/fonts/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 6.0,
                margin: EdgeInsets.all(10),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: FittedBox(
                        child: Text('\$${transation[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(transation[index].tittle,style: Theme.of(context).textTheme.headline6,),
                  subtitle: Text(DateFormat.yMMMd().format(transation[index].date),),
                  trailing: IconButton(onPressed:()=> deleteTranceAction(transation[index].id), icon: Icon(Icons.delete)),
                ),
              );
            },
            itemCount: transation.length,
          );
  }
}
