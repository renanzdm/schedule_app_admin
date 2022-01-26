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

  static String formatForMoney(
      {required int price, String monetarySymbol = 'R\$'}) {
      String valueString = price.toString();
      var listChars = valueString.split('').reversed.toList();
      for(int i=0;i<listChars.length;i++){
        if(i==2){
          listChars.insert(i,',');
        }
        if(i!=0&&i%6==0){
          listChars.insert(i,'.');
        }


      }
      return listChars.reversed.join();

  }

  static String getTimeString(int min) {
    final int hour = min ~/ 60;
    final int minutes = min % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}';
  }
}