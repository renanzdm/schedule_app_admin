import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app_admin/app/ui/widgets/dialog_content_default.dart';
import 'package:schedule_app_admin/modules/login/ui/login_controller.dart';

import '../../service/shared_preferences_service.dart';

class AppBarCustomWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  const AppBarCustomWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => DialogSimpleContentDefault(
                      title: 'Deseja sair de sua conta?',
                      onConfirmFunction: () async {
                        final SharedPreferencesService _sharedPreferences =
                            SharedPreferencesService();
                            await _sharedPreferences.clearPreferences();
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      onCancelFunction: () {
                        Navigator.pop(context);
                      },
                      cancelTextButton: 'Cancelar',
                      confirmTextButton: 'Deslogar'));
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
