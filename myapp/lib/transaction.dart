import 'package:flutter/material.dart';

class Transaction {
  late String content;
  late double amount;
  late DateTime createDate;
  //constructor
  Transaction({required this.content,required this.amount, required this.createDate});
  @override
  String toString() {
    // TODO: implement toString
    return 'content: $content, amount: $amount';
  }
}