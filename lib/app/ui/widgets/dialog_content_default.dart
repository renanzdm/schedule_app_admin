import 'package:flutter/material.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';

class DialogSimpleContentDefault extends StatelessWidget {
  final String title;
  final VoidCallback onConfirmFunction;
  final VoidCallback onCancelFunction;
  final String cancelTextButton;
  final String confirmTextButton;

  const DialogSimpleContentDefault(
      {Key? key,
      required this.title,
      required this.onConfirmFunction,
      required this.onCancelFunction,
      required this.cancelTextButton,
      required this.confirmTextButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        width: 320,
        child: Card(
          margin: EdgeInsets.all(20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(22),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                     TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.grey.shade900),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: context.themeGrey,
                    ),
                    onPressed: onCancelFunction,
                    child: Text(
                      cancelTextButton,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                   ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: context.themeRed,
                    ),
                    onPressed: onConfirmFunction,
                    child: Text(
                      confirmTextButton,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
               
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
