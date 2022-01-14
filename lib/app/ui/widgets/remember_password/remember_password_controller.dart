import 'package:get/get.dart';

class RememberPasswordController extends GetxController {
  var checkBoxValue = RxBool(false);

  void changeValueCheckBox(bool? value) {
    checkBoxValue.value = !checkBoxValue.value;
  }
}
