import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:new_spark/screens/screens.dart';

import '../widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => SigninScreen()));
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GradientText(
          text: 'Unity',
          style: const TextStyle(
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontStyle: FontStyle.italic),
          gradient:
              LinearGradient(colors: [Colors.purple, Colors.blue.shade400]),
        ),
      ),
    );
  }
}
