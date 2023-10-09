import 'package:admin_mosquito_project/utils/colour.dart';
import 'package:flutter/material.dart';

ThemeData mosquitoTheme() {
  final ThemeData base = ThemeData(fontFamily: 'Mitr');

  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: greenPrimary,
      onPrimary: whitePerl,
      secondary: lightGreen,
      onSecondary: whitePerl,
      background: whitePerl,
      onBackground: litBlack,
    ),
    textTheme: base.textTheme.copyWith(
      headlineLarge: base.textTheme.headlineLarge!.copyWith(
        fontFamily: 'Mitr',
        fontSize: 40,
        fontWeight: FontWeight.bold,
        // fontStyle: FontStyle.italic,
      ),
      headlineMedium: base.textTheme.headlineMedium!.copyWith(
        fontSize: 36,
        fontFamily: 'Mitr',
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: base.textTheme.headlineSmall!.copyWith(
        fontSize: 26,
        fontFamily: 'Mitr',
      ),
      bodyLarge: base.textTheme.bodyLarge!.copyWith(
        fontSize: 24,
        fontFamily: 'Mitr',
      ),
      bodyMedium: base.textTheme.bodyLarge!.copyWith(
        fontSize: 20,
        fontFamily: 'Mitr',
      ),
      bodySmall: base.textTheme.bodySmall!.copyWith(
        fontFamily: 'Mitr',
        fontSize: 18,
      ),
    ),
  );
}
