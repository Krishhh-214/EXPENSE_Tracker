import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';/* lock the screen orientation*/
// for color scheme for global variable
var kColorScheme = ColorScheme.fromSeed(seedColor:
const Color.fromARGB(255, 96, 59, 181),);

// This is for dark color
var kDarkColorScheme =
    ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor:const  Color.fromARGB(255, 5, 99, 125),
    );

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {  /*this is for locking device orientation*/
    // and run app ko isme daal denge
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkColorScheme,
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onPrimaryContainer,
            ),
          ),
        ),

        debugShowCheckedModeBanner: false,
        // theme: ThemeData(useMaterial3: true,),
        theme: ThemeData().copyWith(colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.onPrimaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
          datePickerTheme: const DatePickerThemeData(
              backgroundColor: Colors.lightGreenAccent),
          textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16),
          ),

        ),

        // scaffoldBackgroundColor:
        // // const Color.fromARGB(255, 220 , 189, 252)),
        //
        themeMode: ThemeMode.system, /* for default theme when start app*/
        home: const Expenses(),
      ),
    );
  // });
}
