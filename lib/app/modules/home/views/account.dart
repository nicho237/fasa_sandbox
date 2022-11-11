import 'package:fasa_sandbox/app/data/services/fasapay_service.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final String account;
  const MyWidget({required this.account, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: FasapayServices.account(account),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.toString());
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
