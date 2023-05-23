import 'package:flutter/material.dart';
import 'package:new_spark/config/palette.dart';
import 'package:new_spark/screens/nav_screen.dart';
import 'package:new_spark/screens/screens.dart';
import 'package:new_spark/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SparK',
      debugShowCheckedModeBanner: false,
      routes: {
        '/signin': (context) => const SigninScreen(),
        '/nav': (context) => NavScreen()
      },
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Palette.scaffold),
      //home: const SplashScreen(),
      home: const NavScreen(),
    );
  }
}
