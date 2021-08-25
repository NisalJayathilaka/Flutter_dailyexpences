import 'package:flutter/material.dart';
import 'package:my_app/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:my_app/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTranasaction;
  Chart(this.recentTranasaction);
  List<Map<String, dynamic>> get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekdays = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTranasaction.length; i++) {
        if (recentTranasaction[i].date.day == weekdays.day &&
            recentTranasaction[i].date.month == weekdays.month &&
            recentTranasaction[i].date.year == weekdays.year) {
          totalSum += recentTranasaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekdays).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get tottalSpending {
    return groupedTransactionValue.fold(0.0,
        (double previousValue, element) => previousValue + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(20.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
               tottalSpending ==0.0 ? 0.0: (data['amount'] as double) / tottalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
