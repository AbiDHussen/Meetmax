import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meetmax/debug_helper.dart';
import 'package:meetmax/models/comment.dart';
import 'package:meetmax/models/post.dart';
import 'package:meetmax/models/story.dart';
import 'package:meetmax/models/user.dart';
import 'package:meetmax/screens/feed_screen.dart';
import 'package:meetmax/screens/signup_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(StoryAdapter());
  Hive.registerAdapter(CommentAdapter());

  await Hive.openBox<User>('users');
  await Hive.openBox('auth');
  await Hive.openBox<Post>('posts');
  await Hive.openBox<Story>('stories');
  await Hive.openBox<Comment>('comments');

 // clearAllData();//////////////Clear All The Data of Hive

  runApp(const MeetmaxApp());
}

class MeetmaxApp extends StatefulWidget {
  const MeetmaxApp({super.key});

  @override
  State<MeetmaxApp> createState() => _MeetmaxAppState();
}

class _MeetmaxAppState extends State<MeetmaxApp> {
  final AuthService _authService = AuthService();
  late Widget _startScreen;

  @override
  void initState() {
    super.initState();

    final user = _authService.getCurrentUser();
    _startScreen = (user != null) ? const FeedPage() : const SignUpScreen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meetmax',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: _startScreen,
    );
  }
}