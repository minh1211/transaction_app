import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'transaction.dart';
import 'package:myapp/TransactionList.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _contextController = TextEditingController();
  final _amountController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  //define states
  Transaction _transaction = Transaction(content: '', amount: 0.0, createDate: DateTime.now());
  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(this);
  }

  void _inserTransaction() {
    //You must validate information first
    if (_transaction.content.isEmpty ||
        _transaction.amount == 0 ||
        _transaction.amount.isNaN) {
      return;
    }
      _transaction.createDate = DateTime.now();
      _transactions.add(_transaction);
      _transaction = Transaction(content: '', amount: 0.0, createDate: DateTime.now());
      _contextController.text = '';
      _amountController.text = '';
  }
  void _onButtonShowModalSheet(){
    showModalBottomSheet(context: this.context,
        builder: (context){
      return Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Content'),
            controller: _contextController,
            onChanged: (text) {
              setState(() {
                _transaction.content = text;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount(money)'),
            controller: _amountController,
            onChanged: (text) {
              setState(() {
                _transaction.amount = double.tryParse(text) ?? 0;
              });
            },
          ),
          Container(
            padding: EdgeInsets.all(10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(child: SizedBox(child: RaisedButton(
                  color: Colors.green,
                  child: Text('Save', style: TextStyle(fontSize: 16, color: Colors.white),),
                  onPressed: (){
                    setState((){
                      this._inserTransaction();
                    });
                  },
                ), height: 50,)),
                Padding(padding: EdgeInsets.only(left: 10)),
                Expanded(child: SizedBox(child: RaisedButton(
                  color: Colors.pink,
                  child: Text('Cannel', style: TextStyle(fontSize: 16, color: Colors.white),),
                  onPressed: (){
                    print('Press cannel');
                  },
                ), height: 50,))
              ],
            )
          )
        ],
      );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction manager'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                this._inserTransaction();
              });
            },
          )
        ],
      ),
      key: _scaffoldkey,
      body: SafeArea(
        minimum: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // TextField(
              //   decoration: InputDecoration(labelText: 'Content'),
              //   controller: _contextController,
              //   onChanged: (text) {
              //     setState(() {
              //       _transaction.content = text;
              //     });
              //   },
              // ),
              // TextField(
              //   decoration: InputDecoration(labelText: 'Amount(money)'),
              //   controller: _amountController,
              //   onChanged: (text) {
              //     setState(() {
              //       _transaction.amount = double.tryParse(text) ?? 0;
              //     });
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              ButtonTheme(
                height: 50,
                child: FlatButton(
                  child: Text(
                    'Insert Transaction',
                    style: TextStyle(fontSize: 18),
                  ),
                  color: Colors.pinkAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    this._onButtonShowModalSheet();
                    _scaffoldkey.currentState?.showSnackBar(SnackBar(
                      content: Text(
                          'transaction list: ' + _transactions.toString()),/**/
                      duration: Duration(seconds: 3),
                    ));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              TransactionList(transactions: _transactions)
            ],
          ),
        ),
      ),
    );
  }
}
