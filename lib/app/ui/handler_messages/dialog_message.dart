import 'package:flutter/material.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';

class DialogAlertAction {
  static Future<void> showDialogWidget(
      {required BuildContext context,
      String titleDialog = '',
      String textCancelButton = 'Cancelar',
      String textConfirmButton = 'Confirmar',
       Function()? confirmFunction}) async {
    var sizes = MediaQuery.of(context).size;
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            height: 140,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    titleDialog,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: context.themeRed,
                            fixedSize: Size(sizes.width * 0.3, 40.0),
                          ),
                          onPressed: confirmFunction,
                          child: Text(
                            textConfirmButton,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: context.themeGrey,
                            fixedSize: Size(sizes.width * 0.3, 40.0),
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: Text(
                            textCancelButton,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
