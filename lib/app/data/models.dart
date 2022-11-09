import 'dart:convert';

import 'package:fasa_sandbox/app/data/services/fasapay_service.dart';

class ReadFromJson {
  static Future<BalanceModel?> balance() async {
    final String response = await FasapayServices.balance();
    Map<String, dynamic> data = (json.decode(response)
        as Map<String, dynamic>)["fasa_response"]["balance"];

    if (response.isEmpty) {
      return null;
    } else {
      return BalanceModel(
        usd: data["USD"],
        idr: data["IDR"],
      );
    }
  }

  static Future<List<HistoryModel?>> history() async {
    final String response = await FasapayServices.history(
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    );
    var data = json.decode(response);

    return (data["fasa_response"]["history"]["detail"] as List)
        .map((e) => HistoryModel.fromMap(e))
        .toList();
  }

  static Future<DetailModel?> detail(String batchnumber) async {
    final String response = await FasapayServices.detail(batchnumber);
    Map<String, dynamic> data = (json.decode(response)
        as Map<String, dynamic>)["fasa_response"]["detail"];
    print(data);
    if (response.isEmpty) {
      return null;
    } else {
      return DetailModel(
          date: data["date"],
          amount: data["amount"],
          batchnumber: data["batchnumber"],
          currency: data["currency"],
          fee: data["fee"],
          from: data["from"],
          note: data["note"],
          status: data["status"],
          time: data["time"],
          to: data["to"],
          type: data["type"]);
    }
  }
}

class DetailModel {
  final String batchnumber;
  final String type;
  final String to;
  final String amount;
  final String date;
  final String time;
  final String fee;
  final String from;
  final String status;
  final String note;
  final String currency;

  DetailModel({
    required this.amount,
    required this.batchnumber,
    required this.currency,
    required this.date,
    required this.fee,
    required this.from,
    required this.note,
    required this.status,
    required this.time,
    required this.to,
    required this.type,
  });
}

class BalanceModel {
  final String idr;
  final String usd;
  BalanceModel({required this.idr, required this.usd});
}

class HistoryModel {
  final String batchnumber;
  final String type;
  final String to;
  final String amount;
  final String dateTime;
  final String from;
  final String status;
  final String note;
  final String currency;

  HistoryModel({
    required this.batchnumber,
    required this.type,
    required this.to,
    required this.amount,
    required this.dateTime,
    required this.from,
    required this.note,
    required this.status,
    required this.currency,
  });

  factory HistoryModel.fromMap(Map<String, dynamic> data) {
    return HistoryModel(
        batchnumber: data["batchnumber"],
        type: data["type"],
        to: data["to"],
        amount: data["amount"],
        dateTime: data["datetime"],
        from: data["from"],
        note: data["note"],
        currency: data["currency"],
        status: data["status"]);
  }
}
