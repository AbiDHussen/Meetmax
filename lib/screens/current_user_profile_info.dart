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
    final user = usersBox.values.cast<User>().firstWhereOrNull(
      (u) => u.email == currentUserEmail,
    );

    if (user == null) {
      return const Scaffold(body: Center(child: Text('User not found')));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Your Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          const SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black12,
              child: const Icon(Icons.person, size: 60, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              user.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(user.email, style: const TextStyle(color: Colors.grey)),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.cake_outlined, color: Colors.blueAccent),
            title: Text(
              'Birthdate: ${user.birthDate?.toString().split(' ')[0] ?? 'Not set'}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person_outline, color: Colors.blueAccent),
            title: Text(
              'Gender: ${user.gender ?? 'Not specified'}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Divider(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                authBox.delete('currentUserEmail');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (_) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
