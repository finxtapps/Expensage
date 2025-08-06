import 'package:flutter/material.dart';
import '../Widgets/signUpScreenWidgets/HeaderSection.dart';
import '../Widgets/signUpScreenWidgets/SignUpForm.dart';

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
              Theme.of(context).colorScheme.primary.withOpacity(0.7),
              Theme.of(context).colorScheme.secondary,
            ],
          ),
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
      ),
    );
  }
}
