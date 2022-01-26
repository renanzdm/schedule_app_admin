import 'package:flutter/material.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';

class RememberPassword extends StatefulWidget {
  final Function(bool?)? onChanged;
  final bool valueCheck;
  const RememberPassword({Key? key, this.onChanged, required this.valueCheck})
      : super(key: key);

  @override
  State<RememberPassword> createState() => _RememberPasswordState();
}

class _RememberPasswordState extends State<RememberPassword> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return context.themeRed;
      }
      return context.themeGrey;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          fillColor: MaterialStateProperty.resolveWith(getColor),
          onChanged: widget.onChanged,
          value: widget.valueCheck,
        ),
        const Text(
          'Lembra a senha',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
