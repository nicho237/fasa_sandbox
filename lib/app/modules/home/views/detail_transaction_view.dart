import 'package:fasa_sandbox/app/data/models.dart';
import 'package:fasa_sandbox/app/data/services/format_currency.dart';
import 'package:fasa_sandbox/app/modules/home/controllers/home_controller.dart';
import 'package:fasa_sandbox/app/modules/home/views/home_view.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DetailTransactionView extends StatelessWidget {
  final String batchnumber;
  const DetailTransactionView({Key? key, required this.batchnumber})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: ReadFromJson.detail(batchnumber),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final details = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.data!.batchnumber),
                  Text(
                    snapshot.data!.status,
                    style: TextStyle(
                        color: snapshot.data!.status == "FINISH"
                            ? Colors.green
                            : Colors.redAccent),
                  ),
                  Text(FormatCurrency.currency(
                    details!.currency,
                    details.amount,
                  )),
                  Text(details.from),
                  Text(details.time),
                  Text(details.date)
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
