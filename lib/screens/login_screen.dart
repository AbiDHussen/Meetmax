import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:meetmax/screens/forgot_password_screen.dart';
import 'package:meetmax/screens/signup_screen.dart';
import 'package:meetmax/services/auth_service.dart';
import 'package:meetmax/widgets/customButtonAndTextfield/custom_text_field.dart';
import 'package:meetmax/widgets/customButtonAndTextfield/social_button.dart';
import 'package:meetmax/widgets/customButtonAndTextfield/custom_elevated_button.dart';
import 'package:meetmax/screens/feed_screen.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.06;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),

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
                        Row(
                          children: [
                            Expanded(
                              child: SocialButton(
                                text: 'Log in with Google',
                                icon: const FaIcon(
                                  FontAwesomeIcons.google,
                                  color: Colors.black54,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SocialButton(
                                text: 'Log in with Apple',
                                icon: const FaIcon(
                                  FontAwesomeIcons.apple,
                                  color: Colors.black54,
                                ),
                                onPressed: () {},
                              ),
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

                        CustomTextField(
                          controller: _emailController,
                          label: 'Your Email',
                          icon: const FaIcon(FontAwesomeIcons.at),
                        ),

                        const SizedBox(height: 16),

                        CustomTextField(
                          controller: _passwordController,
                          label: 'Password',
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

                        const SizedBox(height: 10),

                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runSpacing: 4,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
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
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const ForgotPasswordScreen(),
                                  ),
                                );
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
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();

                            final success = await _authService.signIn(
                              email: email,
                              password: password,
                            );

                            if (success) {
                              final authBox = Hive.box('auth');

                              if (_rememberMe) {
                                authBox.put('currentUserEmail', email);
                              } else {
                                authBox.delete('currentUserEmail');
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Login successful')),
                              );

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const FeedPage(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Invalid email or password'),
                                ),
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
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
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
      ),
    );
  }
}
