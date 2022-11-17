import 'package:fasa_sandbox/app/data/models.dart';
import 'package:fasa_sandbox/app/data/services/fasapay_service.dart';
import 'package:fasa_sandbox/app/data/services/format_currency.dart';
import 'package:fasa_sandbox/app/modules/home/views/account.dart';
import 'package:fasa_sandbox/app/modules/home/views/detail_transaction_view.dart';
import 'package:fasa_sandbox/app/modules/home/views/keyboard_view.dart';
import 'package:fasa_sandbox/app/modules/home/views/transfer_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Get.to(() => KeyboardView()),
        ),
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: BalanceInfo(),
              ),
              InputWidget(),
              AccountInfo(),
              HistoryInfo(),
            ],
          ),
        ),
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1), () {
            setState(() {});
          });
        },
      ),
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
    return FutureBuilder(
        future: ReadFromJson.balance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListTile(
              onTap: () {
                setState(() {});
              },
              tileColor: Colors.blueGrey,
              title: Text(
                FormatCurrency.currency("IDR", snapshot.data!.idr),
              ),
              subtitle: Text(
                FormatCurrency.currency("USD", snapshot.data!.usd),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
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
    final controller = Get.put(InputController());

    return SizedBox(
      height: Get.height,
      child: FutureBuilder<List<HistoryModel?>>(
          future: ReadFromJson.history(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<HistoryModel?>? histories = snapshot.data;

              return ListView.builder(
                itemCount: histories!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blueGrey,
                    child: ListTile(
                      title: Text(FormatCurrency.currency(
                          histories[index]!.currency,
                          histories[index]!.amount)),
                      subtitle:
                          Text(controller.typeInfo(histories[index]!.type)),
                      leading: CircleAvatar(
                        backgroundColor: controller.typeService(
                          histories[index]!.type,
                        ),
                      ),
                      trailing: Text(
                        histories[index]!.batchnumber,
                        style: TextStyle(
                            color: histories[index]!.type == "FINISH"
                                ? Colors.redAccent
                                : Colors.green),
                      ),
                      onTap: () async {
                        controller.getDetail(histories[index]!.batchnumber,
                            histories[index]!.to);

                        Get.to(() => DetailView(
                              account: controller._account.value,
                              batchnumber: controller._batchnumber.value,
                            ));
                      },
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class InputController extends GetxController {
  final _batchnumber = "".obs;
  final _account = "".obs;

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

  getDetail(String batchnumber, String account) {
    _batchnumber(batchnumber);
    _account(account);
  }
}
