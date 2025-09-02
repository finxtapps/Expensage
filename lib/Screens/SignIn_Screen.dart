import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/signInScreen_Widgets/SignInForm.dart';

import '../component/login_signup_Header.dart';
import '../theme/header_Color.dart';
import '../theme/theme_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: themeProvider.currentTheme == 'Pink'
              ? HeaderColor.pinkGradient
              : themeProvider.currentTheme == 'Green'
              ? HeaderColor.greenGradient
              : themeProvider.currentTheme == 'Blue'
              ? HeaderColor.blueGradient
              : themeProvider.currentTheme == 'Orange'
              ? HeaderColor.orangeGradient
              : HeaderColor.darkGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              LoginSignupHeader(btn_title: 'Sign Up',),
              // const SignInHeaderSection(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'ExpenSage',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(MediaQuery.of(context).size.width * .25),
                      topRight: Radius.circular(MediaQuery.of(context).size.width * .25),
                    ),
                    color:!isDarkMode
                        ? Colors.white.withOpacity(.1)
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: SignInForm(
                      formKey: _formKey,

                      emailController: _emailController,
                      passwordController: _passwordController,

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
