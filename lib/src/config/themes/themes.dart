import 'package:doft/src/core/utils/colors_manager.dart';
import 'package:flutter/material.dart';

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        displayMedium: base.displayMedium!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headlineLarge: base.headlineLarge!
            .copyWith(fontWeight: FontWeight.w500, fontSize: 40),
        headlineMedium: base.headlineMedium!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: base.headlineSmall!.copyWith(
          fontWeight: FontWeight.w300,
        ),
        titleLarge: base.titleLarge!.copyWith(
          fontSize: 20,
        ),
        titleMedium: base.titleMedium!.copyWith(
          fontSize: 20,
        ),
        bodySmall: base.bodySmall!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyLarge: base.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
        labelLarge: base.labelLarge!.copyWith(fontSize: 20.0),
        labelMedium: base.labelMedium!.copyWith(fontSize: 16.0),
        labelSmall: base.labelSmall!.copyWith(fontSize: 13.0),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: ColorManager.mouvemaBrown900,
        bodyColor: ColorManager.mouvemaBrown900,
      );
}

ThemeData buildTheme() {
  final ThemeData base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      brightness: Brightness.light,
      primary: ColorManager.mouvemaPink400,
      onPrimary: Colors.white,
      secondary: ColorManager.mouvemaBrown900,
      error: ColorManager.mouvemaErrorRed,
      outline: ColorManager.mouvemaPink100,
      surface: const Color.fromARGB(255, 255, 238, 233),
    ),
    dividerColor: ColorManager.mouvemaPink100,

    /// App Text Theme
    textTheme: _buildShrineTextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: ColorManager.mouvemaPink100,
    ),
    scaffoldBackgroundColor: ColorManager.mouvemaBackgroundWhite,

    appBarTheme: const AppBarTheme(
      foregroundColor: ColorManager.mouvemaBrown900,
      backgroundColor: ColorManager.mouvemaPink100,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color.fromARGB(255, 243, 222, 216),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          width: 2.0,
          color: ColorManager.mouvemaBrown900,
        ),
      ),
      floatingLabelStyle: const TextStyle(
        color: ColorManager.mouvemaBrown900,
      ),
    ),
  );
}

// ThemeData oldThemeData() {
//   return ThemeData(
//     useMaterial3: true,

//     // main colors
//     primaryColor: ColorsManager.primary,

//     scaffoldBackgroundColor: ColorsManager.scafoldBackground,

//     // appbar
//     appBarTheme: AppBarTheme(
//       color: ColorsManager.primary,
//       elevation: 4,
//       centerTitle: true,
//     ),
//     textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),

//     elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.black,
//       elevation: 4,
//       foregroundColor: Colors.white,
//     )),
//     textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(
//       foregroundColor: Colors.white,
//     )),

//     // elevatedButtonTheme: ElevatedButtonThemeData(
//     //     style: ElevatedButton.styleFrom(
//     //       // ! styles should not bet hardcoded
//     //         textStyle: TextStyle(color: ColorsManager.secondary),
//     //         shape: RoundedRectangleBorder(
//     //             borderRadius: BorderRadius.circular(12)))),
//     // todo: nkamlou bqyet les buttons
//     // text field
//     inputDecorationTheme: InputDecorationTheme(
//         contentPadding: const EdgeInsets.all(8),
//         hintStyle: const TextStyle(color: Colors.black38),

//         /// Todo:  [hintStyle] , [labelStyle] ...
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: ColorsManager.enabled, width: 1.5),
//             borderRadius: const BorderRadius.all(Radius.circular(8))),

//         // focused
//         focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: ColorsManager.primary, width: 1.5),
//             borderRadius: const BorderRadius.all(Radius.circular(8))),

//         // error border
//         errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: ColorsManager.error, width: 1.5),
//             borderRadius: const BorderRadius.all(Radius.circular(8))),

//         // focused error
//         focusedErrorBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: ColorsManager.primary, width: 1.5),
//             borderRadius: const BorderRadius.all(Radius.circular(8)))),

//     //
//   );
// }
