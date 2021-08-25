import 'dart:ui';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/widgets/chart.dart';
import 'package:my_app/widgets/new_transaction.dart';
import 'package:my_app/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.black,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white)
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                
              ),
        ),
      ),
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   amount: 69.99,
    //   date: DateTime.now(),
    //   tittle: 'New shoes',
    // ),
    // Transaction(
    //   id: 't2',
    //   amount: 16.53,
    //   date: DateTime.now(),
    //   tittle: 'Weekly Grosries',
    // ),
  ];
  List<Transaction> get _recentTrasaction {
    return _userTransaction
        .where(
          (element) => element.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void _addNewTransAction(String txTitle, double txAmount,DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        tittle: txTitle,
        amount: txAmount,
        date: chosenDate);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTranastion(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransAction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
    void _deleteTransaction(String id)
    {
      setState(() {
        _userTransaction.removeWhere((element) {
          return element.id==id;
        });
      });
    }
  @override
  Widget build(BuildContext context) {
    final dynamic
     appBar = Platform.isIOS ? CupertinoNavigationBar(
      middle: Text(
          'Personal Expences',
          style: TextStyle(fontFamily: 'Open Sans'),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: Icon(CupertinoIcons.add),
              onTap: () =>_startAddNewTranastion(context),
            )
          ],
        ),
    ): AppBar(
        title: Text(
          'Personal Expences',
          style: TextStyle(fontFamily: 'Open Sans'),
        ),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTranastion(context),
            icon: Icon(Icons.add),
          )
        ],
      );
      
       final pageBody = SafeArea(child:  SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height:(MediaQuery.of(context).size.height- appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.3,
            child: Chart(_recentTrasaction),),
            // transaction card list
            Container(height:(MediaQuery.of(context).size.height- appBar.preferredSize.height-MediaQuery.of(context).padding.top) * 0.7,
            child: TransactionsList(_userTransaction,_deleteTransaction),),
          ],
        ),
      )
       );

    return Platform.isIOS ? CupertinoPageScaffold(child: pageBody,navigationBar: appBar,) : Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Platform.isIOS ? Container(): FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTranastion(context),
      ),
    );
  }
}
