import 'dart:convert';
import 'package:crypto/crypto.dart';

class Utils {
  static String hashPassword(String password, String salt) {
    var codec = const Utf8Codec();
    final key = codec.encode(password);
    final saltBytes = codec.encode(salt);
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(saltBytes);
    return digest.toString();
  }

  static RegExp regexEmail() {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  }

  static String formatDoubleForMoney({required double price,String monetarySymbol='R\$'}) {
    String valueFormatted='';
    String valueForString = price.toStringAsPrecision(2);
    List<String> listStrings = valueForString.split('.');
    if (listStrings.length == 1) {
      String value = listStrings.first;
    valueFormatted = value + ',' + '00';
    } else if (listStrings.length > 1) {
      String valueOfDot = listStrings[1];
      if (valueOfDot.length == 1) {
        valueOfDot = valueOfDot + '0';
      }
     valueFormatted =listStrings[0] + "," + valueOfDot;
    }
    return '$monetarySymbol $valueFormatted';
  }

  static String getTimeString(int min) {
    final int hour = min ~/ 60;
    final int minutes = min % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
  }




}
