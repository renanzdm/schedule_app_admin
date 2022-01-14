import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schedule_app_admin/app/ui/theme_default/colors_theme.dart';

class ManagerUiTheme {
  ManagerUiTheme._();

  static ThemeData theme(BuildContext context) => ThemeData(
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: context.themeGrey),
        textTheme:
            GoogleFonts.metrophobicTextTheme(Theme.of(context).textTheme),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: context.themeRed,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,

          ),
        ),
        timePickerTheme: TimePickerThemeData(
          hourMinuteTextColor: context.themeRed,
          dialHandColor: context.themeRed,
          helpTextStyle: TextStyle(
            color: context.themeRed,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(Colors.grey.shade800),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
              context.themeRed.withOpacity(.6),
            ),
          ),
        ),
        scaffoldBackgroundColor: context.backgroundColor,
        primaryColor: context.themeOrange,
      );
}
