import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';


class TextFormFieldWidget extends StatefulWidget {
  final String? labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData suffixIcon;
  final IconData? suffixIconPassword;
  final List<TextInputFormatter>? formatters;
  final bool isPasswordField;

  const TextFormFieldWidget({
    Key? key,
    this.labelText = '',
    required this.controller,
    this.validator,
    required this.suffixIcon, this.formatters,
  })  : isPasswordField = false,
        suffixIconPassword = null,
        super(key: key);

  const TextFormFieldWidget.password({
    Key? key,
    this.labelText,
    required this.controller,
    this.validator,
    required this.isPasswordField, this.formatters,
  })  : suffixIcon = Icons.visibility_outlined,
        suffixIconPassword = Icons.visibility_off_outlined,
        super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {

  bool _passwordField=false;
  @override
  void initState() {
    _passwordField = widget.isPasswordField;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      inputFormatters:widget.formatters,
      obscureText: _passwordField,
      validator: widget.validator,
      controller: widget.controller,
      style:const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: widget.isPasswordField
            ? IconButton(
          color: Colors.white,
          onPressed: () {
            setState(() {
              if (widget.isPasswordField) {
                _passwordField = !_passwordField;
              }
            });
          },
          icon: Icon(_passwordField
              ? widget.suffixIconPassword
              : widget.suffixIcon),
        ): Icon(
          widget.suffixIcon,
          color: Colors.white,
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.themeGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.themeGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: context.themeGrey,
          ),
        ),
      ),
    );
  }
}
