import 'package:flutter/material.dart';
import '../Widgets/signInScreen_Widgets/SignInForm.dart';
import '../Widgets/signInScreen_Widgets/SignIn_HeaderSection.dart';
import '../Widgets/signUpScreenWidgets/HeaderSection.dart';
import '../Widgets/signUpScreenWidgets/SignUpForm.dart';

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
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SignInHeaderSection(),
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
                child: SignInForm(
                  formKey: _formKey,

                  emailController: _emailController,
                  passwordController: _passwordController,

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
