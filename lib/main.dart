import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meetmax/models/comment.dart';
import 'package:meetmax/models/post.dart';
import 'package:meetmax/models/story.dart';
import 'package:meetmax/models/user.dart';
import 'package:meetmax/screens/feed_screen.dart';
import 'package:meetmax/screens/forgot_password_screen.dart';
import 'package:meetmax/screens/signup_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'screens/create_post_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(StoryAdapter());

  await Hive.openBox<User>('users');
  await Hive.openBox('auth'); // 🛑 This is usually the one people forget
  await Hive.openBox<Post>('posts');
  await Hive.openBox<Story>('stories');
  await Hive.openBox<Comment>('comments');

  runApp(const MeetmaxApp());
}


class MeetmaxApp extends StatelessWidget {
  const MeetmaxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meetmax',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const SignUpScreen(),
    );
  }
}
