import 'package:flutter/material.dart';
import 'transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({required this.transactions});

  ListView _buildListView() {
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: index % 2 == 0 ? Colors.green : Colors.teal,
              elevation: 10,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        transactions[index].content,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      Text(
                        'Date: ${DateFormat.yMd().format(transactions[index].createDate)}',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                    ],
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('${transactions[index].amount} \$',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                      )
                    ],
                  ))
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 500,
      child: this._buildListView(),
    );
  }
}
