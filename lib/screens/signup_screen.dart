import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetmax/widgets/custom_text_field.dart';
import 'package:meetmax/widgets/social_button.dart';

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

                // 🔹 Top header with logo and language
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
                      items: <String>[
                        'English (UK)',
                        'English (US)',
                        'Bangla',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                const Text(
                  'Getting Started',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create an account to continue and connect\nwith the people.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 24),

                // 🔹 Social Login Buttons
                Row(
                  children: [
                    SocialButton(
                      text: 'Log in with Google',
                      icon: const FaIcon(FontAwesomeIcons.google, color: Colors.black54),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 12),
                    SocialButton(
                      text: 'Log in with Apple',
                      icon: const FaIcon(FontAwesomeIcons.apple, color: Colors.black54),
                      onPressed: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // 🔹 OR divider
                Row(
                  children: const [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                        endIndent: 10,
                      ),
                    ),
                    Text("OR", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
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
                  icon: FaIcon(FontAwesomeIcons.lock),
                  obscure: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
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
                        _dobController.text = "${picked.toLocal()}".split(' ')[0];
                      });
                    }
                  },
                ),

                const SizedBox(height: 12),

                // 🔹 Gender Toggle
                Row(
                  children: [
                    const Icon(Icons.male_outlined),
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
                    )
                  ],
                ),

                const SizedBox(height: 16),

                // 🔹 Sign Up Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Handle sign up
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
                  ),
                ),

                const SizedBox(height: 16),

                // 🔹 Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        // TODO: Navigate to Sign In screen
                      },
                      child: const Text('Sign In', style: TextStyle(color: Colors.blue)),
                    ),
                  ],
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
