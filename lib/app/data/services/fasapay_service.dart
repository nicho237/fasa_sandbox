// ignore_for_file: prefer_interpolation_to_compose_strings, non_constant_identifier_namesim
import 'dart:convert';

import 'package:xml2json/xml2json.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'url.dart';

class FasapayServices {
  String text1;
  FasapayServices({required this.text1});
  static createToken(String apiKey, String apiSecretWord) {
    var dateUtc = DateTime.now().toUtc();
    String dateFormat = DateFormat('yyyyMMddkk').format(dateUtc);
    var str = "$apiKey:$apiSecretWord:$dateFormat";
    var hashed = utf8.encode(str);
    var hashing = sha256.convert(hashed);

    return "$hashing";
  }

  static buildAuth(String apiKey, String token) {
    var str = '<auth><api_key>$apiKey</api_key><token>$token</token></auth>';

    return str;
  }

  static xmlAuth() async {
    var apiKey = "44f36b6cea1dce3c8cf756d752c640f9";
    var apiSecretword = "123456";
    var token = createToken(apiKey, apiSecretword);
    var auth = buildAuth(apiKey, token);

    return auth;
  }

  static transfer(
    String amount,
    String to,
    String note,
    String currency,
  ) async {
    var xml = '<fasa_request>' +
        await xmlAuth() +
        '<transfer id="2456">' +
        '<to>$to</to>' +
        '<amount>$amount</amount>' +
        '<currency>$currency</currency>' +
        '<note>$note</note>' +
        '</transfer>' +
        '</fasa_request>';

    return await getResponse(xml);
  }

  static detail(
    String batchnumber,
  ) async {
    var xml = '<fasa_request>' +
        await xmlAuth() +
        '<detail>$batchnumber</detail>' +
        '</fasa_request>';
    return await getResponse(xml);
  }

  static account(
    String account,
  ) async {
    var xml = '<fasa_request>' +
        await xmlAuth() +
        '<detail>$account</detail>' +
        '</fasa_request>';
    return await getResponse(xml);
  }

  static history(
    String startDate,
    String endDate,
    String type,
    String orderBy,
    String order,
    String page,
    String perPage,
  ) async {
    var xml = '<fasa_request>' +
        await xmlAuth() +
        '<history>' +
        '<start_date>$startDate</start_date>' +
        '<end_date>$endDate</end_date>' +
        '<type>$type</type>' +
        '<order_by>$orderBy</order_by>' +
        '<order>$order</order>' +
        '<page>$page</page>' +
        '<page_size>$perPage</page_size>' +
        '</history>' +
        '</fasa_request>';

    return await getResponse(xml);
  }

  static Future balance() async {
    var xml = '<fasa_request id="000001">' +
        await xmlAuth() +
        '<balance>IDR</balance>' +
        '<balance>USD</balance>' +
        '</fasa_request>';

    return await getResponse(xml);
  }

  static getResponse(xml) async {
    try {
      Xml2Json xml2json = Xml2Json();
      final response = await http.post(
        Uri.parse(url_master),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: {"req": xml},
      );

      if (response.statusCode == 200) {
        xml2json.parse(response.body);
        var message = xml2json.toParkerWithAttrs();
        //Map<String, dynamic> respon = json.decode(message);

        return message;
      } else {
        return 'Error Server';
      }
    } catch (e) {
      return 'Time out';
    }
  }
}
