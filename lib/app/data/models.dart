import 'dart:convert';
import 'dart:math';


import 'package:flutter/services.dart';

class ReadFromJson {
  static Future<BalanceModel?> balance() async {
    final String response =
        await rootBundle.loadString('assets/local_data/balance.json');
    Map<String, dynamic> data = (json.decode(response) as Map<String,dynamic>)["balance"];
    
    if (response.isEmpty) {
       return null;
    } else {
     return BalanceModel(balance: data["IDR"]);
    }
    
  }

  static Future<List<HistoryModel?>> history() async {
    final String response =
        await rootBundle.loadString('assets/local_data/transaksi.json');
    var data = json.decode(response);

    return (data["detail"] as List).map((e) => HistoryModel.fromMap(e)).toList();
  }
  
}

class BalanceModel {
  final String balance;
  BalanceModel({required this.balance});
}

class HistoryModel {
  final String batchnumber;
   final String type;
    final String to ;
     final String amount;
      
  

  HistoryModel({
    required this.batchnumber,
    required this.type,
    required this.to,
    required this.amount
    
  });

  factory HistoryModel.fromMap(Map<String, dynamic> data){
    return HistoryModel(
      batchnumber: data["batchnumber"],
      type: data["type"],
      to: data["to"],
      amount: data["amount"]
      
      );

  }
}