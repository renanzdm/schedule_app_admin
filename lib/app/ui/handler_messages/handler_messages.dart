import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin MessageMixin on GetxController {
  void messageListener(Rxn<MessageModel> message) {
    ever<MessageModel?>(
      message,
      (model) {
        if (model != null) {
          if (Get.isSnackbarOpen) {
            Get.back();
          } else {
            Get.rawSnackbar(
                animationDuration: const Duration(milliseconds: 1000),
                messageText: Text(model.message),
                title: model.title,
                backgroundColor: model.type.color());
          }
        }
      },
    );
  }
}

class MessageModel {
  final String title;
  final String message;
  final MessageType type;

  MessageModel({
    required this.title,
    required this.message,
    required this.type,
  });

  MessageModel.error({
    required this.title,
    required this.message,
  }) : type = MessageType.error;

  MessageModel.info({
    required this.title,
    required this.message,
  }) : type = MessageType.info;
}

enum MessageType { error, info }

extension MessageTypeExtension on MessageType {
  Color color() {
    switch (this) {
      case MessageType.error:
        return Colors.redAccent.shade700;
      case MessageType.info:
        return Colors.green;
    }
  }
}
