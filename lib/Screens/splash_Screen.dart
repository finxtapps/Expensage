import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/header_Color.dart';
import '../theme/theme_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
Navigator.pushReplacementNamed(context, '/landingpage');
    });
  }
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient:  themeProvider.currentTheme == 'Pink'
            ? HeaderColor.pinkGradient
            : themeProvider.currentTheme == 'Green'
            ? HeaderColor.greenGradient
            : themeProvider.currentTheme == 'Blue'
            ? HeaderColor.blueGradient
            : themeProvider.currentTheme == 'Orange'
            ? HeaderColor.orangeGradient
            : HeaderColor.darkGradient,
      ),
      child: Center(
        child: Text("ExpenSage",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
