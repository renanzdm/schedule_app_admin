import 'package:flutter/services.dart';

class PhoneMask extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String phone = newValue.text;
    String formatted = '';
    phone = phone.replaceAll(RegExp(r'\D'), '');
    if (phone.length > 11) {
      return oldValue;
    }
    for (int i = 0; i < phone.length; i++) {
      if (i==0||i==2) {
        formatted += i==0?'(' : ') ';
      }else if(i==7){
        formatted += ' ';
      }
      formatted += phone[i];
    }
    return newValue.copyWith(
        text: formatted,
        selection:
        TextSelection.fromPosition(TextPosition(offset: formatted.length)));
  }
}