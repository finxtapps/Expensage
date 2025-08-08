import 'package:flutter/material.dart';


class SignInForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;


  const SignInForm({super.key,
    required this.formKey,

    required this.emailController,
    required this.passwordController,

  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 30.0,vertical: 15),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
               SizedBox(height: 10),
              Text("Welcome Back",style: TextStyle(color: Colors.black,fontSize: 38,fontWeight: FontWeight.bold),),

              Text("Enter your details below",style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.bold),),
              const SizedBox(height: 40),
              _buildInputField(
                controller: widget.emailController,
                hintText: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 18),
              _buildInputField(
                controller: widget.passwordController,
                hintText: 'Password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 40),
              _buildSignUpButton(context),
              const SizedBox(height: 15),
              Text("Forgot your Password?",style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.bold),),
              const SizedBox(height: 50),
              _buildDivider(),
              const SizedBox(height: 28),
              _buildSocialButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: MediaQuery.of(context).size.width*.12,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey[400]!,
          width: 1.5,
        ),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.grey[600],
            size: 22,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          if (hintText == 'Email' && !value.contains('@')) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*.4,
      height: MediaQuery.of(context).size.width*.13,
      child: ElevatedButton(
        onPressed: () {
          if (widget.formKey.currentState!.validate()) {
            // Handle sign up
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sign In functionality would be implemented here'),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 3,
        ),
        child: const Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'or sign in with',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButtons(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: _buildSocialButton(
            "assets/icon _Images/icons8-google-480.png",
            'Google',
            Colors.white,
            Colors.black87,
                () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Google sign up would be implemented here'),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 15),

        Expanded(
          child: _buildSocialButton(
            "assets/icon _Images/icons8-linkedin-480.png",
            // Container(
            //   height: 30,
            //   width: 30,
            //   child:Image.asset("assets/icon Images/icons8-linkedin-480.png",fit: BoxFit.cover,),
            // ),SizedBox(width: 10,),
            'LinkedIn',
            Colors.white,
            Colors.black87,
                () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('LinkedIn sign up would be implemented here'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
      String image,
      String text,
      Color backgroundColor,
      Color textColor,
      VoidCallback onPressed,
      ) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width*.3,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(
            color: Colors.grey[300]!,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child:Image.asset(image,fit: BoxFit.cover,),
            ),const SizedBox(width: 10,),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}