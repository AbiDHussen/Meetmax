import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'package:meetmax/models/user.dart';
import 'package:meetmax/screens/login_screen.dart';

class CurrentUserProfileInfo extends StatelessWidget {
  const CurrentUserProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final authBox = Hive.box('auth');
    final currentUserEmail = authBox.get('currentUserEmail');

    final usersBox = Hive.box<User>('users');
    final user = usersBox.values
        .cast<User>()
        .firstWhereOrNull((u) => u.email == currentUserEmail);

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('User not found')),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Your Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),

        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 100),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue.shade100,
              child: const Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(user.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                )),
            const SizedBox(height: 8),
            Text(user.email,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                )),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.cake_outlined, color: Colors.blueAccent),
                        const SizedBox(width: 10),
                        Text('Birthdate: ${user.birthDate?.toString().split(' ')[0] ?? 'Not set'}'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.person_outline, color: Colors.blueAccent),
                        const SizedBox(width: 10),
                        Text('Gender: ${user.gender ?? 'Not specified'}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                authBox.delete('currentUserEmail');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
