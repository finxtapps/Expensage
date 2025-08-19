import 'package:flutter/material.dart';


class SignUpForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;

  const SignUpForm({super.key, 
    required this.formKey,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String? _selectedGender;
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 15),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildInputField(
                controller: widget.fullNameController,
                hintText: 'Full name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 10),
              _buildInputField(
                controller: widget.emailController,
                hintText: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              _buildInputField(
                controller: widget.passwordController,
                hintText: 'Password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 10),
              _buildInputField(
                controller: widget.phoneController,
                hintText: 'Phone number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              _buildGenderDropdown(),
              const SizedBox(height: 30),
              _buildSignUpButton(context),
              const SizedBox(height: 25),
              _buildDivider(),
              const SizedBox(height: 25),
              _buildSocialButtons(context),
            ],
          ),
        ),
      ),
    );
  }




  Widget _buildGenderDropdown() {
    return Container(
      height: MediaQuery.of(context).size.width * .12,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey[400]!,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.only(right: 8.0),
        child: DropdownButtonFormField<String>(
          value: _selectedGender,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.people_outline,
              color: Colors.grey[600],
              size: 22,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: MediaQuery.of(context).size.width * .025,
            ),
          ),
          hint: Text(
            "Select Gender",
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          items: ["Male", "Female", "Other"]
              .map((gender) => DropdownMenuItem(
            value: gender,
            child: Text(
              gender,
              style: const TextStyle(fontSize: 14),
            ),
          ))
              .toList(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select gender';
            }
            return null;
          },
          onChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
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
    String? errorText;
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * .12,
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
                  contentPadding:  EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: MediaQuery.of(context).size.width *.025,//10, // Fixed position
                  ),
                  errorStyle: const TextStyle(height: 0), // Hide default error text
                ),
                validator: (value) {
                  String? message;
                  if (value == null || value.isEmpty) {
                    message = 'This field is required';
                  }
                  if (hintText == 'Email' &&
                      value != null &&
                      !value.contains('@')) {
                    message = 'Please enter a valid email';
                  }
                  setState(() => errorText = message);
                  return null; // Prevent default error space
                },
              ),
            ),
            if (errorText != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  errorText!,
                  style:  TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            ]
          ],
        );
      },
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*.4,
      height: 38,
      child: ElevatedButton(
        onPressed: () {
          if (widget.formKey.currentState!.validate()) {
            // Handle sign up
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sign up functionality would be implemented here'),
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
          'Sign up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
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
            'or sign up with',
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
            "assets/images/icon_Images/icons8-google-480.png",
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
    "assets/images/icon_Images/icons8-linkedin-480.png",
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