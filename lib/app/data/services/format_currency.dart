import 'package:intl/intl.dart';

class FormatCurrency {
  static clearDot(String value) {
    if (value != '') {
      final coma = ',';
      final dot = '.';
      final replaceComaWith = '';
      final val1 = value.replaceAll(coma, replaceComaWith);
      final val2 = val1.replaceAll(dot, replaceComaWith);
      return val2;
    }
  }

  static dot(String value) {
    if (value != '') {
      final findComa = ',';
      final replaceComaWith = '';
      final newStringComa = value.replaceAll(findComa, replaceComaWith);

      final find = '.';
      final replaceWith = '';
      final newString = newStringComa.replaceAll(find, replaceWith);

      var myDouble = int.parse(newString);
      return myDouble;
    }
  }

  static currency(
    String locale,
    var value,
  ) {
    String symbol = "";
    if (locale == "USD") {
      locale = "en_US";
      symbol = "\$ ";
    } else if (locale == "IDR") {
      locale = "IDR";
      symbol = "Rp ";
    }
    final amount = NumberFormat.currency(
      locale: locale,
      decimalDigits: 2,
      symbol: symbol,
    ).format(double.parse(value));
    return amount;
  }
}
