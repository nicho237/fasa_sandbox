import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:fasa_sandbox/app/data/services/fasapay_service.dart';

import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController idr = TextEditingController();
    final TextEditingController to = TextEditingController();
    final TextEditingController note = TextEditingController();
    final TextEditingController currency = TextEditingController();
    return Card(
      color: Colors.grey,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(12),
        title: Text("Data Pelanggan"),
        children: [
          ListTile(
            title: const Text("Nominal"),
            subtitle: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              height: 40,
              child: TextField(
                controller: idr,
                keyboardType: TextInputType.number,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    hintText: "xxxxx",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ),
          ListTile(
            title: const Text("Currency"),
            subtitle: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                height: 40,
                child: SizedBox(
                  height: 40,
                  child: CustomDropdown(
                    fillColor: Colors.blueGrey,
                    hintText: 'Pilih Currency',
                    items: const [
                      'IDR',
                      'USD',
                    ],
                    controller: currency,
                  ),
                )),
          ),
          ListTile(
            title: const Text("Penerima"),
            subtitle: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              height: 40,
              child: TextField(
                controller: to,
                textCapitalization: TextCapitalization.characters,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    hintText: "FPXXXXX ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ),
          ListTile(
            title: const Text("Note"),
            subtitle: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              height: 40,
              child: TextField(
                controller: note,
                textCapitalization: TextCapitalization.characters,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    hintText: "Notes",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  FasapayServices.transfer(
                    idr.text,
                    to.text,
                    note.text,
                    currency.text,
                  );
                },
                child: const Icon(Icons.send),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Icon(Icons.history),
              ),
            ],
          )
        ],
      ),
    );
  }
}
