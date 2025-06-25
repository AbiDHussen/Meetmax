import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetmax/screens/login_screen.dart';
import 'package:meetmax/widgets/customButtonAndTextfield/custom_text_field.dart';
import 'package:meetmax/widgets/customButtonAndTextfield/social_button.dart';
import 'package:meetmax/widgets/customButtonAndTextfield/custom_elevated_button.dart';
import 'package:meetmax/services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dobController = TextEditingController();
  final AuthService _authService = AuthService();


  String _selectedGender = 'Male';
  String _selectedLanguage = 'English (UK)';
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),

                // 🔹 Top Header with Logo and Language
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.favorite, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'Meetmax',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    DropdownButton<String>(
                      value: _selectedLanguage,
                      icon: const Icon(Icons.arrow_drop_down),
                      underline: Container(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLanguage = newValue!;
                        });
                      },
                      items: <String>['English (UK)', 'English (US)', 'Bangla']
                          .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          })
                          .toList(),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                const Text(
                  'Getting Started',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create an account to continue and connect\nwith the people.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                // 🔹 Main Signup Card Container
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // 🔹 Social Login Buttons
                      Row(
                        children: [
                          SocialButton(
                            text: 'Log in with Google',
                            icon: const FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.black54,
                            ),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 12),
                          SocialButton(
                            text: 'Log in with Apple',
                            icon: const FaIcon(
                              FontAwesomeIcons.apple,
                              color: Colors.black54,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // 🔹 OR Divider
                      Row(
                        children: const [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                              endIndent: 10,
                            ),
                          ),
                          Text(
                            "OR",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                              indent: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // 🔹 Form Fields
                      CustomTextField(
                        controller: _emailController,
                        label: 'Your Email',
                        icon: const FaIcon(FontAwesomeIcons.at),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _nameController,
                        label: 'Your Name',
                        icon: const FaIcon(FontAwesomeIcons.faceSmile),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Create Password',
                        icon: const FaIcon(FontAwesomeIcons.lock),
                        obscure: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: _dobController,
                        label: 'Date of birth',
                        icon: const Icon(Icons.calendar_today_outlined),
                        readOnly: true,
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              _dobController.text = "${picked.toLocal()}".split(
                                ' ',
                              )[0];
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 12),

                      // 🔹 Gender Selection
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.male_outlined, color: Colors.grey),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: 'Male',
                                    groupValue: _selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value!;
                                      });
                                    },
                                  ),
                                  const Text('Male'),
                                  Radio<String>(
                                    value: 'Female',
                                    groupValue: _selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value!;
                                      });
                                    },
                                  ),
                                  const Text('Female'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 🔹 Sign Up Button
                      CustomElevatedButton(
                        text: 'Sign Up',
                        onPressed: () async {
                          final success = await _authService.signUp(
                            name: _nameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                            imageUrl: '', // Placeholder or default URL
                            birthDate: DateTime.parse(_dobController.text.trim()),

                            gender: _selectedGender,
                          );

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Sign up successful!')),
                            );
                            // Navigate to home or main screen
                            // Navigate to login screen
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Email already exists!')),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // 🔹 Already Have an Account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
