import 'package:flutter/material.dart';

import '../icons_custom_icons.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';


class ErrorLoadedWidget extends StatelessWidget {
  final String error;
  final dynamic Function()? reloadFunction;
  const ErrorLoadedWidget({Key? key, required this.error, this.reloadFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
           Icon(
            IconsCustom.errorOutline,
            color: context.themeOrange,
            size: 40,
          ),
          Text(
            error,
            style: const TextStyle(color: Colors.white,fontSize: 20),
          ),
          IconButton(
              onPressed: () async {
                await reloadFunction?.call();
              },
              icon: const Icon(
                Icons.restart_alt,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
