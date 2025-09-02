import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  File? _profileImage; // selected image store hogi

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Choose from Gallery"),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    setState(() {
                      _profileImage = File(image.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take a Photo"),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? image =
                  await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    setState(() {
                      _profileImage = File(image.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
      isDarkMode ? Colors.black : Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDarkMode
                      ? [Colors.black, Colors.black]
                      : [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
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
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: MediaQuery.of(context).size.width * .08,
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
                          const SizedBox(width: 24),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Profile picture with picker
                      InkWell(
                        onTap: _pickImage,
                        child: ProfileImageSection(
                          title: 'Edit picture',
                          imageFile: _profileImage, // yaha pass kiya
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ),
            // Your form container below ...
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration:
              BoxDecoration(color: isDarkMode ? Colors.black : Colors.white),
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

  /// ------ Your InputField builder & Save button (same as before) --------
  Widget _buildInputField({
    required TextEditingController controller,
    required String title,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    String? errorText;

    return StatefulBuilder(
      builder: (context, setState) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 5),
              child: Text(
                title,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).colorScheme.primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                controller: controller,
                obscureText: obscureText,
                keyboardType: keyboardType,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  errorStyle: TextStyle(height: 0),
                ),
                validator: (value) {
                  String? message;
                  if (value == null || value.isEmpty) {
                    message = 'This field is required';
                  } else if (title == "Email" && !value.contains('@')) {
                    message = 'Please enter a valid email';
                  } else if (title == "Phone number" &&
                      (value.length < 10 || value.length > 12)) {
                    message = 'Please enter a valid phone number';
                  }

                  setState(() => errorText = message);
                  return null;
                },
              ),
            ),
            if (errorText != null) ...[
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 5),
                child: Text(
                  errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            ]
          ],
        );
      },
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: MediaQuery.of(context).size.width * .4,
      height: MediaQuery.of(context).size.height * .055,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            // save logic
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isDarkMode
              ? const Color(0xFFD44D5C)
              : Theme.of(context).colorScheme.secondary,
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
}




















// import 'package:flutter/material.dart';
//
// import '../Widgets/profile_Info_Screen_Widgets/profile_image_section.dart';
//
// class PersonalInformation extends StatefulWidget {
//   const PersonalInformation({super.key});
//
//   @override
//   State<PersonalInformation> createState() => _PersonalInformationState();
// }
//
// class _PersonalInformationState extends State<PersonalInformation> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final TextEditingController fullNameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     return Scaffold(
//       backgroundColor: isDarkMode ? Colors.black : Theme.of(context).scaffoldBackgroundColor,
//       body: SingleChildScrollView(
//
//         child: Column(
//           children: [
//             Container(
//               decoration:  BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   // topRight: Radius.circular(40),
//                   // topLeft: Radius.circular(40),
//                   bottomLeft: Radius.circular(80),
//                   bottomRight: Radius.circular(80),
//                 ),
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors:isDarkMode ?[
//                     Colors.black,
//                     Colors.black
//                   ] :[
//                     Theme.of(context).colorScheme.primary,
//                     Theme.of(context).colorScheme.secondary,
//                     // Color(0xFFD44D5C), // First color
//                     // Color(0xFF6E2830), // Second color
//                   ],
//                 ),
//               ),
//               child: SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20.0,
//                     vertical: 10,
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child:  Icon(
//                               Icons.arrow_back,
//                               color: Colors.white,
//                               size: MediaQuery.of(context).size.width * .08,
//                             ),
//                           ),
//                           const Expanded(
//                             child: Text(
//                               'Profile',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 24), // Balance the back button
//                         ],
//                       ),
//                       const SizedBox(height: 30),
//                       InkWell(
//                           onTap: ,
//                           child: const ProfileImageSection(title: 'Edit picture',)),
//                       const SizedBox(height: 5),
//
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.only(top: 20),
//               decoration:  BoxDecoration(color:isDarkMode ? Colors.black : Colors.white),
//               child: Padding(
//                 padding: const EdgeInsets.all(30.0),
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 30),
//                       _buildInputField(
//                         title: "Name",
//                         controller: fullNameController,
//
//
//                       ),
//                       const SizedBox(height: 20),
//                       _buildInputField(
//                         title: "Email",
//                         controller: emailController,
//
//
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//
//
//                       const SizedBox(height: 18),
//                       _buildInputField(
//                         controller: phoneController,
//                         title: "Phone number",
//
//
//                         keyboardType: TextInputType.phone,
//                       ),
//                       const SizedBox(height: 40),
//                       _buildSaveButton(context),
//                       const SizedBox(height: 28),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInputField({
//     required TextEditingController controller,
//     required String title,
//     bool obscureText = false,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     String? errorText;
//
//     return StatefulBuilder(
//       builder: (context, setState) {
//         final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title
//             Padding(
//               padding: const EdgeInsets.only(left: 12.0, bottom: 5),
//               child: Text(
//                 title,
//                 style: TextStyle(
//                   color:isDarkMode ? Colors.white : Colors.grey[600],
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//
//             // Input field
//             Container(
//               decoration: BoxDecoration(
//                 color:isDarkMode?Theme.of(context).scaffoldBackgroundColor :Theme.of(context).colorScheme.primary.withOpacity(.1),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: TextFormField(
//                 controller: controller,
//                 obscureText: obscureText,
//                 keyboardType: keyboardType,
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 12,
//                   ),
//                   errorStyle: TextStyle(height: 0), // hide default error
//                 ),
//                 validator: (value) {
//                   String? message;
//                   if (value == null || value.isEmpty) {
//                     message = 'This field is required';
//                   } else if (title == "Email" && !value.contains('@')) {
//                     message = 'Please enter a valid email';
//                   } else if (title == "Phone number" &&
//                       (value.length < 10 || value.length > 12)) {
//                     message = 'Please enter a valid phone number';
//                   }
//
//                   setState(() => errorText = message);
//                   return null; // prevent default error widget
//                 },
//               ),
//             ),
//
//             // Custom error below field
//             if (errorText != null) ...[
//               Padding(
//                 padding: const EdgeInsets.only(left: 12.0, top: 5),
//                 child: Text(
//                   errorText!,
//                   style: const TextStyle(color: Colors.red, fontSize: 12),
//                 ),
//               ),
//             ]
//           ],
//         );
//       },
//     );
//   }
//
//
//   Widget _buildSaveButton(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     return SizedBox(
//       width: MediaQuery.of(context).size.width*.4,
//       height: MediaQuery.of(context).size.height*.055,
//       child: ElevatedButton(
//         onPressed: () {
//           if (formKey.currentState!.validate()) {
//             // Handle sign up
//             // ScaffoldMessenger.of(context).showSnackBar(
//             //   const SnackBar(
//             //     content: Text(
//             //       'Sign up functionality would be implemented here',
//             //     ),
//             //   ),
//             // );
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor:isDarkMode ? Color(0xFFD44D5C) : Theme.of(context).colorScheme.secondary,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           elevation: 3,
//         ),
//         child: const Text(
//           'Save',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }
