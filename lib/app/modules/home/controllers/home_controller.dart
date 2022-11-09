import 'package:fasa_sandbox/app/data/services/fasapay_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final _amount = "".obs;
  final _to = "".obs;
  final _currency = "".obs;
  final _note = "Standart Service".obs;
  final _batchnumber = "".obs;

  void getDataTransfer(
    String to,
    String amount,
    String currency,
    String note,
  ) {
    _amount(amount);
    _currency(currency);
    _to(to);
    _note(note);
  }

  typeService(String type) {
    var typeColor = Colors.white;

    if (type == "Transfer Out") {
      typeColor = Colors.orange;
    }
    if (type == "topup") {
      typeColor = Colors.blue;
    }
    return typeColor;
  }

  typeInfo(String type) {
    String typeString = "";
    if (type == "topup") {
      typeString = "Top Up";
    }
    if (type == "Transfer Out") {
      typeString = type;
    }
    return typeString;
  }

  getDetail(String batchnumber) {
    _batchnumber(batchnumber);
  }
}
