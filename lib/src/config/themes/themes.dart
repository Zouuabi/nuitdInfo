import 'package:doft/src/core/colors_manager.dart';
import 'package:flutter/material.dart';

ThemeData myThemeData() {
  return ThemeData(
    useMaterial3: true,

    // main colors
    primaryColor: ColorsManager.primary,

    scaffoldBackgroundColor: ColorsManager.scafoldBackground,

    // appbar
    appBarTheme: AppBarTheme(
      color: ColorsManager.primary,
      elevation: 4,
      centerTitle: true,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      elevation: 20,
      foregroundColor: Colors.white,
    )),
    textButtonTheme: TextButtonThemeData(
        style:
            TextButton.styleFrom(foregroundColor: Colors.black, elevation: 20)),

    // elevatedButtonTheme: ElevatedButtonThemeData(
    //     style: ElevatedButton.styleFrom(
    //       // ! styles should not bet hardcoded
    //         textStyle: TextStyle(color: ColorsManager.secondary),
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(12)))),
    // todo: nkamlou bqyet les buttons
    // text field
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(8),
        hintStyle: TextStyle(color: Colors.black),

        /// Todo:  [hintStyle] , [labelStyle] ...
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.enabled, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(8))),

        // focused
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.primary, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(8))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.error, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(8))),

        // focused error
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsManager.primary, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(8)))),

    //
  );
}
