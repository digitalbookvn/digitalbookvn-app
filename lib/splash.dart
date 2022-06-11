import 'dart:async';

import 'package:arbook/views/startup/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {


  @override
  void initState() {
    super.initState();
    goToNextScreen();
  }

  goToNextScreen() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFFDFF1EB),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.35,
            ),
            Image.asset(
              'assets/images/splash-logo.png',
              height: MediaQuery.of(context).size.width * 0.14,
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            const Text(
              'AR BOOK',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Nunito',
                color: Color(0xFFF97923),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.08,
            ),
            Text(
              FlutterI18n.translate(context, "splash.slogan"),
              style: TextStyle(
                fontSize: 14,
                fontFamily: FlutterI18n.translate(context, "font"),
                color: const Color(0xFF006338),
              ),
            ),
            const Spacer(),
            Image.asset(
              'assets/images/splash.png',
              width: MediaQuery.of(context).size.width,
              height: 0.96 * MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
