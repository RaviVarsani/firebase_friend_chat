import 'package:flutter/material.dart';
import 'package:friend_chat/utilities/app_colors.dart';

final lightTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: AppBarTheme(backgroundColor: AppColors.primary),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.teal),
);

// class MyThemes {
//   static final darkTheme = ThemeData(
//       primarySwatch: Colors.deepOrange,
//       scaffoldBackgroundColor: Colors.white,
//       appBarTheme: AppBarTheme(
//           titleSpacing: 20,
//           elevation: 0,
//           titleTextStyle: const TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//           iconTheme: const IconThemeData(
//             color: Colors.white,
//           )),
//       bottomNavigationBarTheme: BottomNavigationBarThemeData(
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.deepOrange,
//         unselectedItemColor: Colors.grey,
//         elevation: 20,
//       ),
//       textTheme: const TextTheme(
//           bodyText1: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.w600,
//         color: Colors.white,
//       )));
//
//   static final lightTheme = ThemeData(
//       primarySwatch: Colors.deepOrange,
//       scaffoldBackgroundColor: Colors.white,
//       appBarTheme: const AppBarTheme(
//         titleSpacing: 20,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         titleTextStyle: TextStyle(
//           color: Colors.black,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//         ),
//         iconTheme: IconThemeData(
//           color: Colors.black,
//         ),
//       ),
//       textTheme: const TextTheme(
//         bodyText1: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//           color: Colors.black,
//         ),
//       ),
//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.deepOrange,
//         elevation: 20,
//         backgroundColor: Colors.white,
//       ));
// }
