import 'package:flutter/material.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';

class ButtonAddOrRemoveVacancy extends StatelessWidget {
  const ButtonAddOrRemoveVacancy({Key? key,required  this.icon,required  this.onTap}) : super(key: key);
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        child:  Icon(
          icon,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
          color: context.themeRed,
          shape: BoxShape.circle,
          border: Border.all(
            width: 1,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
