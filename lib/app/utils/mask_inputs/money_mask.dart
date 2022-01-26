import 'package:flutter/services.dart';

class MoneyMask extends TextInputFormatter {
  final String separator;
  final int qtdDigitsAddSeparator;
  final String moneySymbol;
  final int precisionValueCents;

  MoneyMask({this.precisionValueCents=2,
    this.moneySymbol = r'R$',
    this.qtdDigitsAddSeparator = 3,
    this.separator = '.'});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text.replaceAll(RegExp(r'\D'), '');
    value = value.split('').reversed.join();
    List<String> listChars = [];
    int count = 0;
    for (var i = 0; i < value.length; i++) {
      if (i > 0) {
        if (i == precisionValueCents) {
          listChars.insert(0, ',');
        }
        if (i > 2) {
          count++;
        }
        if (count == qtdDigitsAddSeparator) {
          listChars.insert(0, separator);
          count = 0;
        }
      }
      listChars.insert(0, value[i]);
    }

    listChars.insert(0, moneySymbol);
    String formatted = listChars.join();

    return newValue.copyWith(
        text: formatted,
        selection:
        TextSelection.fromPosition(TextPosition(offset: formatted.length)));
  }
}