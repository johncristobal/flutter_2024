import 'package:intl/intl.dart';

class Formats {
  static String readerNumber(double number) {
    final formatter = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: "",
    ).format(number);
    return formatter;
  }
}