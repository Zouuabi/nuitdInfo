import 'package:flutter/material.dart';

import '../../core/utils/color_manager.dart';

TextTheme _buildShrineTextTheme(TextTheme base, BuildContext context) {
  // final textScaleFactor = MediaQuery.of(context).textScaleFactor;
  // final size = MediaQuery.of(context).size;
  return base
      .copyWith(
        displayLarge: base.displayLarge!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        displayMedium: base.displayMedium!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        displaySmall: base.displaySmall!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headlineLarge: base.headlineLarge!.copyWith(),
        headlineMedium: base.headlineMedium!.copyWith(),
        headlineSmall: base.headlineSmall!.copyWith(),
        titleLarge: base.titleLarge!.copyWith(),
        titleMedium: base.titleMedium!.copyWith(),
        bodyLarge: base.bodyLarge!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        bodySmall: base.bodySmall!.copyWith(
          fontWeight: FontWeight.w400,
        ),
        labelLarge: base.labelLarge!.copyWith(),
        labelMedium: base.labelMedium!.copyWith(),
        labelSmall: base.labelSmall!.copyWith(),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: ColorManager.mouvemaBrown900,
        bodyColor: ColorManager.mouvemaBrown900,
      );
}

ThemeData buildTheme(BuildContext context) {
  final ThemeData base = ThemeData.light(useMaterial3: true);
  final size = MediaQuery.of(context).size;
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      brightness: Brightness.light,
      primary: Colors.teal,
      onPrimary: Colors.white,
      error: ColorManager.mouvemaErrorRed,
      outline: const Color.fromARGB(255, 234, 255, 253),
      surface: const Color.fromARGB(255, 234, 255, 253),
    ),
    // divider
    dividerColor: Color.fromARGB(255, 69, 160, 151),

    /// App Text Theme
    textTheme: _buildShrineTextTheme(base.textTheme, context),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Color.fromARGB(255, 255, 255, 255),
    ),
    // Scaffold
    scaffoldBackgroundColor: Color.fromARGB(255, 189, 223, 219),
    // each icon will have this default size
    // iconTheme: IconThemeData(size: size.width * 0.07),

    appBarTheme: const AppBarTheme(
      titleSpacing: 2,
      centerTitle: true,
      foregroundColor: ColorManager.mouvemaBrown900,
      backgroundColor: Color.fromARGB(255, 60, 182, 154),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        iconSize: 40,
        shape: CircleBorder(),
        splashColor: Color.fromARGB(255, 120, 213, 191)),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color.fromARGB(255, 211, 255, 255),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          width: 0.5,
          color: Colors.teal,
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
