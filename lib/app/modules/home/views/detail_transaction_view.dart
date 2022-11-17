import 'package:fasa_sandbox/app/data/models.dart';
import 'package:fasa_sandbox/app/data/services/fasapay_service.dart';
import 'package:fasa_sandbox/app/data/services/format_currency.dart';
import 'package:fasa_sandbox/app/modules/home/controllers/home_controller.dart';
import 'package:fasa_sandbox/app/modules/home/views/home_view.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DetailView extends StatefulWidget {
  final String batchnumber;
  final String account;
  const DetailView({
    Key? key,
    required this.batchnumber,
    required this.account,
  }) : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TransactionSuccess(
                batchnumber: widget.batchnumber,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: AlignmentDirectional.topCenter,
                width: Get.width,
                height: 350,
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    DetailPelanggan(
                      account: widget.account,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionPending extends StatelessWidget {
  const TransactionPending({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: Get.width,
      height: 280,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            height: 132,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.pending_actions_outlined,
                  color: Colors.orange,
                  size: 50,
                ),
                Text("Transaksi Pending",
                    style: TextStyle(fontSize: 18, color: Colors.orange)),
                Text(
                  "Rp 200.000.000",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.orange),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Pembayaran"),
                    Text("27 Juli 2022, 12:00 PM")
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 52,
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CircleAvatar(
                    radius: 20,
                    child: Text(
                      "VA",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Text(
                    "Virtual Account",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Order ID"),
                    Text("Transaction ID"),
                    Text("Payment Link")
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      "SANDBOX-G80300523",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "939492013240134000234",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "No",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TransactionSuccess extends StatelessWidget {
  final String batchnumber;
  const TransactionSuccess({required this.batchnumber, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return FutureBuilder(
      future: ReadFromJson.detail(batchnumber),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final details = snapshot.data;
          return Container(
            padding: const EdgeInsets.all(12),
            width: Get.width,
            height: 280,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  height: 132,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        CupertinoIcons.checkmark_seal_fill,
                        color: Colors.green,
                        size: 50,
                      ),
                      Text("Transaksi Berhasil",
                          style: TextStyle(fontSize: 18, color: Colors.green)),
                      Text(
                        FormatCurrency.currency(
                            details!.currency, details.amount),
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.green),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(controller.typeInfo(details.type)),
                          Text('${details.date}, ${details.time}')
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 52,
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        CircleAvatar(
                          radius: 20,
                          child: Text(
                            "VA",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          "Virtual Account",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Order ID"),
                          Text("Transaction ID"),
                          Text("Payment Link")
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            details.batchnumber,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "939492013240134000234",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "No",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class DetailPelanggan extends StatelessWidget {
  final String account;
  const DetailPelanggan({required this.account, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.symmetric(horizontal: 25),
        title: ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text("Detail Pelanggan"),
        ),
        children: [
          FutureBuilder(
            future: ReadFromJson.account(account),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final accounts = snapshot.data;
                return ListTile(
                  dense: true,
                  visualDensity: VisualDensity.compact,
                  title: Text(
                    "Nama",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  subtitle: Text(
                    accounts!.fullname,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                );
              }
              return LinearProgressIndicator();
            },
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            title: Text(
              "Telpon",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            subtitle: Text(
              "085802752570",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            title: Text(
              "Email",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            subtitle: Text(
              "sentinel@gmail.com",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            title: Text(
              "Alamat",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
            subtitle: Text(
              "Indonesia, Asia, Bumi, Tata Surya, Bimasakti",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
