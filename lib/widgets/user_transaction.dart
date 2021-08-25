// import 'package:flutter/material.dart';
// import 'package:my_app/models/transaction.dart';
// import 'package:my_app/widgets/transaction_list.dart';

// import 'new_transaction.dart';

// class UserTransaction extends StatefulWidget {
//   UserTransaction({Key? key}) : super(key: key);

//   @override
//   _UserTransactionState createState() => _UserTransactionState();
// }

// class _UserTransactionState extends State<UserTransaction> {
//   // final List<Transaction> _userTransaction = [
//   //   Transaction(
//   //     id: 't1',
//   //     amount: 69.99,
//   //     date: DateTime.now(),
//   //     tittle: 'New shoes',
//   //   ),
//   //   Transaction(
//   //     id: 't2',
//   //     amount: 16.53,
//   //     date: DateTime.now(),
//   //     tittle: 'Weekly Grosries',
//   //   ),
   
//   // ];

//   // void _addNewTransAction(String txTitle, double txAmount) {
//   //   final newTx = Transaction(
//   //       id: DateTime.now().toString(),
//   //       tittle: txTitle,
//   //       amount: txAmount,
//   //       date: DateTime.now());

//   //       setState(() {
//   //         _userTransaction.add(newTx);
//   //       });
//   // }
  

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         NewTransaction(_addNewTransAction),
//         TransactionsList(_userTransaction),
//       ],
//     );
//   }
// }
