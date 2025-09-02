import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';

class SignUpForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;

  const SignUpForm({
    super.key,
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
  Currency? _selectedCurrency;

  // Country code → flag emoji converter
  String countryCodeToEmoji(String countryCode) {
    if (countryCode.length != 2) return '';
    return String.fromCharCodes(
      countryCode.toUpperCase().codeUnits.map((codeUnit) => codeUnit + 127397),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Theme.of(context).colorScheme.primary
            : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            border: Border.all(
              color:isDarkMode? Color(0xFFD44D5C) : Colors.transparent,
              width: 4,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
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
                const SizedBox(height: 10),
                _buildCurrencyDropdown(), // 🔹 Currency Dropdown Added
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
      ),
    ));
  }

  // ------------------ Currency Dropdown ------------------
  Widget _buildCurrencyDropdown() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: MediaQuery.of(context).size.width * .12,
      decoration: BoxDecoration(
        color: isDarkMode
            ? Theme.of(context).scaffoldBackgroundColor
            : Colors.grey[50],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey[400]!,
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: () {
          showCurrencyPicker(
            context: context,
            showFlag: true,
            showCurrencyName: true,
            showCurrencyCode: true,
            onSelect: (Currency currency) {
              setState(() {
                _selectedCurrency = currency;
              });
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Icon(
                Icons.monetization_on_outlined,
                color: isDarkMode
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _selectedCurrency == null
                      ? "Select Currency"
                      : "${countryCodeToEmoji(_selectedCurrency!.code.substring(0, 2))}  ${_selectedCurrency!.code} - ${_selectedCurrency!.name}",
                  style: TextStyle(
                    fontSize: 13,
                    color: _selectedCurrency == null
                        ? Colors.grey[600]
                        : isDarkMode
                        ? Colors.white
                        : Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------ Existing Code (Gender + Inputs + Buttons) ------------------
  Widget _buildGenderDropdown() {
    String? errorText;
    return StatefulBuilder(
      builder: (context, setState) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * .12,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Colors.grey[50],
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
                      color: isDarkMode
                          ? Colors.white
                          : Theme.of(context).colorScheme.primary,
                      size: 22,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: MediaQuery.of(context).size.width * .025,
                    ),
                    errorStyle: const TextStyle(height: 0),
                  ),
                  hint: Text(
                    "Select Gender",
                    style: TextStyle(
                        color: isDarkMode
                            ? Colors.white
                            : Colors.grey[600],
                        fontSize: 12),
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
                    String? message;
                    if (value == null || value.isEmpty) {
                      message = 'Please select gender';
                    }
                    setState(() => errorText = message);
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                      errorText = null;
                    });
                  },
                ),
              ),
            ),
            if (errorText != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
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

  // ------------------ Input Field (same as your code) ------------------
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
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * .12,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Colors.grey[50],
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
                    color: isDarkMode ? Colors.white : Colors.grey[600],
                    fontSize: 12,
                  ),
                  prefixIcon: Icon(
                    icon,
                    color: isDarkMode
                        ? Colors.white
                        : Theme.of(context).colorScheme.primary,
                    size: 22,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: MediaQuery.of(context).size.width * .025,
                  ),
                  errorStyle: const TextStyle(height: 0),
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
                  return null;
                },
              ),
            ),
            if (errorText != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
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

  // ------------------ SignUp Button ------------------
  Widget _buildSignUpButton(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      width: MediaQuery.of(context).size.width * .4,
      height: 38,
      child: ElevatedButton(
        onPressed: () {
          if (widget.formKey.currentState!.validate()) {
            if (_selectedCurrency == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please select a currency")),
              );
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Sign up with ${_selectedCurrency!.code} - ${_selectedCurrency!.name}'),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:isDarkMode? Color(0xFFD44D5C): Theme.of(context).colorScheme.secondary,
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

  // ------------------ Divider + Social Buttons (same as your code) ------------------
  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(height: 1, color: Colors.grey[300]),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'or sign up with',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ),
        Expanded(
          child: Container(height: 1, color: Colors.grey[300]),
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
                    content: Text('Google sign up would be implemented here')),
              );
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildSocialButton(
            "assets/images/icon_Images/icons8-linkedin-480.png",
            'LinkedIn',
            Colors.white,
            Colors.black87,
                () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('LinkedIn sign up would be implemented here')),
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
      width: MediaQuery.of(context).size.width * .3,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(color: Colors.grey[300]!, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
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

