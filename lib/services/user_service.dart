import 'package:hive/hive.dart';
import 'package:meetmax/models/user.dart';

class UserService {
  final Box<User> userBox = Hive.box<User>('users');

  User? getUserById(String email) {
    try {
      return userBox.values.firstWhere((user) => user.email == email);
    } catch (e) {
      return null; // gracefully return null if not found
    }
  }
}
