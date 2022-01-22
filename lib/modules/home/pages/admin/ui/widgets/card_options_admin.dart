import 'package:flutter/material.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';

class CardOptionsAdmin extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CardOptionsAdmin(
      {Key? key,
      required this.width,
      required this.height,
      required this.title,
      required this.icon,required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(16) ,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(3, 5),
            blurRadius: 4,
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap:onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 60,
                color: context.themeRed,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
