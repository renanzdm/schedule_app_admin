import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin LoaderMixin on GetxController {
  void loaderListener(Rx<bool> loaderRx) {
    ever<bool>(
      loaderRx,
      (loading) async {
        if (loading) {
           Get.dialog(
              Center(
                child: CircularProgressIndicator(
                  color: Colors.redAccent.shade700,
                ),
              ),
              barrierDismissible: false);
        } else {
          Get.back();
        }
      },
    );
  }
}
