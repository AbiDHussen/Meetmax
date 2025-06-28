import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meetmax/models/user.dart';
import 'package:meetmax/screens/feed_screen.dart';

class AuthService {
  final Box<User> userBox = Hive.box<User>('users');
  final Box authBox = Hive.box('auth');

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    required String imageUrl,
    required DateTime birthDate,
    required String gender,
  }) async {
    // Check for existing email
    if (userBox.values.any((u) => u.email == email)) return false;

    final user = User(
      name: name,
      email: email,
      password: password,
      imageUrl: imageUrl,
      birthDate: birthDate,
      gender: gender,
    );

    await userBox.add(user);
    authBox.put('currentUserEmail', email);
    return true;
  }

  Future<bool> signIn({required String email, required String password}) async {
    try {
      final user = userBox.values.firstWhere(
        (u) => u.email == email && u.password == password,
      );
      authBox.put('currentUserEmail', email);
      return true;
    } catch (_) {
      return false;
    }
  }

  User? getCurrentUser() {
    final email = authBox.get('currentUserEmail');
    try {
      return userBox.values.firstWhere((u) => u.email == email);
    } catch (_) {
      return null;
    }
  }

  void logout() => authBox.delete('currentUserEmail');

  /// Auto login if user session exists
  void checkAutoLogin(BuildContext context) {
    final rememberedEmail = authBox.get('currentUserEmail');

    if (rememberedEmail != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const FeedPage()),
        );
      });
    }
  }
}
