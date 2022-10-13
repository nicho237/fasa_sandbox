import 'package:fasa_sandbox/app/data/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: const Center(
          child: SizedBox(
            height: 100,
            child: BalanceInfo(),
          )),
    );
  }
}

class BalanceInfo extends StatefulWidget {
  const BalanceInfo({super.key});

  @override
  State<BalanceInfo> createState() => _BalanceInfoState();
}

class _BalanceInfoState extends State<BalanceInfo> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HistoryModel?>>(
      future: ReadFromJson.history(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<HistoryModel?>? histories = snapshot.data;
          return ListView.builder(
            itemCount: histories!.length,
            itemBuilder: ((context, index) {
            return ListTile(
              title: Text(histories[index]!.batchnumber),
            );
          }));
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class HistoryInfo extends StatefulWidget {
  const HistoryInfo({super.key});

  @override
  State<HistoryInfo> createState() => _HistoryInfoState();
}

class _HistoryInfoState extends State<HistoryInfo> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
