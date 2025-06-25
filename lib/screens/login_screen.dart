import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetmax/services/auth_service.dart';
import 'package:meetmax/widgets/customButtonAndTextfield/custom_text_field.dart';
import 'package:meetmax/widgets/customButtonAndTextfield/social_button.dart';
import 'package:meetmax/widgets/customButtonAndTextfield/custom_elevated_button.dart';
import 'package:meetmax/screens/feed_screen.dart'; // or your actual path


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;
  String _selectedLanguage = 'English (UK)';
  final _authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),

                // ✅ Top App Header with logo + language dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Text(
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
                        'Bangla'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Welcome back, you’ve been missed!',
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 24),

                // ✅ Container for Login Form Section
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
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      // Social Buttons
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
                            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
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

                      CustomTextField(
                        controller: _emailController,
                        label: 'Your Email',
                        icon: const FaIcon(FontAwesomeIcons.at),
                      ),

                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
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

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                              ),
                              const Text('Remember me'),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: Navigate to Forgot Password Screen
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      CustomElevatedButton(
                        text: 'Sign In',
                        onPressed: () async {
                          final success = await _authService.signIn(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login successful')),
                            );

                            // Navigate to FeedPage
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const FeedPage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid email or password')),
                            );
                          }
                        },

                      ),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("You haven’t any account? "),
                          GestureDetector(
                            onTap: () {
                              // TODO: Navigate to Sign Up screen
                            },
                            child: const Text(
                              'Sign Up',
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
