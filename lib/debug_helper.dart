import 'package:hive/hive.dart';
import 'package:meetmax/models/user.dart';
import 'package:meetmax/models/post.dart';

Future<void> clearAllData() async {
  final userBox = Hive.box<User>('users');
  final postBox = Hive.box<Post>('posts');

  await userBox.clear();  // clears all users
  await postBox.clear();  // clears all posts (including likes & comments stored inside)
}
