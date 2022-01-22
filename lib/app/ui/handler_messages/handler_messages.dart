import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin MessageMixin on GetxController {
  void messageListener(Rxn<MessageModel> message) {
    ever<MessageModel?>(
      message,
      (model) async {
        if (model != null) {
          Get.bottomSheet(
            Container(
              height: 80,
              width: double.infinity,
              color: model.type.color(),
              child: Row(
                children: [
                  Icon(model.icon, color: Colors.white, size: 60),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        style: TextStyle(
                            color: model.titleColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        model.message,
                        style: TextStyle(color: model.messageColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );

          //  Get.rawSnackbar(
          //       animationDuration: const Duration(milliseconds: 1000),
          //       messageText: Text(
          //         model.message,
          //         style: TextStyle(color: model.messageColor),
          //       ),
          //       titleText: Text(
          //         model.title,
          //         style: TextStyle(
          //             color: model.titleColor,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 18),
          //       ),
          //       icon: Icon(model.icon, color: Colors.white, size: 40),
          //       backgroundColor: model.type.color());
        }
      },
    );
  }
}

class MessageModel {
  final String title;
  final Color titleColor;
  final Color messageColor;
  final String message;
  final MessageType type;
  final IconData icon;

  MessageModel(
      {required this.title,
      required this.message,
      required this.type,
      required this.messageColor,
      required this.titleColor,
      required this.icon});

  MessageModel.error({
    required this.title,
    required this.message,
  })  : type = MessageType.error,
        messageColor = Colors.white,
        titleColor = Colors.white,
        icon = Icons.error_outline_outlined;

  MessageModel.info({
    required this.title,
    required this.message,
  })  : type = MessageType.info,
        messageColor = Colors.white,
        titleColor = Colors.white,
        icon = Icons.insert_emoticon_outlined;
}

enum MessageType { error, info }

extension MessageTypeExtension on MessageType {
  Color color() {
    switch (this) {
      case MessageType.error:
        return Colors.redAccent.shade700;
      case MessageType.info:
        return Colors.green.shade400;
    }
  }
}
