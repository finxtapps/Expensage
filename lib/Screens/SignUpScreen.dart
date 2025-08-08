import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uiproject/theme/header_Color.dart';
import '../Widgets/signUpScreenWidgets/HeaderSection.dart';
import '../Widgets/signUpScreenWidgets/SignUpForm.dart';
import '../theme/theme_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  HeaderColor headerColor = HeaderColor();
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
    final colorScheme = Theme.of(context).colorScheme;
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
              const HeaderSection(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
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
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0,),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),

                        ),
                      ),
                    ),
                    Expanded(
                      child: SignUpForm(
                        formKey: _formKey,
                        fullNameController: _fullNameController,
                        emailController: _emailController,
                        passwordController: _passwordController,
                        phoneController: _phoneController,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
