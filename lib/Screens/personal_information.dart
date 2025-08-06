import 'package:flutter/material.dart';

import '../Widgets/profile_Info_Screen_Widgets/profile_image_section.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFD44D5C), // First color
                    Color(0xFF6E2830), // Second color
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const Expanded(
                            child: Text(
                              'Profile',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 24), // Balance the back button
                        ],
                      ),
                      const SizedBox(height: 30),
                      const ProfileImageSection(),
                      const SizedBox(height: 5),
        
        
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration:  BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      _buildInputField(
                        title: "Name",
                        controller: fullNameController,
        
        
                      ),
                      const SizedBox(height: 20),
                      _buildInputField(
                        title: "Email",
                        controller: emailController,
        
        
                        keyboardType: TextInputType.emailAddress,
                      ),
        
        
                      const SizedBox(height: 18),
                      _buildInputField(
                        controller: phoneController,
                        title: "Phone number",
        
        
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 40),
                      _buildSaveButton(context),
                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String title,


    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(title,style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.bold,fontSize: 18),),
        ),
        Container(
            decoration: BoxDecoration(
              color: const Color(0xFFE16472).withOpacity(.2),
              borderRadius: BorderRadius.circular(15),

            ),
            child: Column(
              children: [

                TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  decoration: const InputDecoration(



                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    if (value == 'Email' && !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ],
            )
        )
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*.4,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            // Handle sign up
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Sign up functionality would be implemented here',
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD44D5C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 3,
        ),
        child: const Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: Colors.grey[300])),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'or sign up with',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
        Expanded(child: Container(height: 1, color: Colors.grey[300])),
      ],
    );
  }
}
