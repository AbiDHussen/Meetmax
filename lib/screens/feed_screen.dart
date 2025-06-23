import 'package:flutter/material.dart';
import 'package:meetmax/data/data.dart';
import 'package:meetmax/widgets/create_post_container.dart';
import 'package:meetmax/widgets/stories_section.dart';
import 'package:meetmax/widgets/post_container.dart';
import 'package:meetmax/widgets/top_bar_section.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          TopBarSection(currentUser: currentUser),
          StoriesSection(stories: stories),
          // CreatePostContainer(currentUser: currentUser),
          // const SizedBox(height: 10),
          // ...posts.map((post) => PostContainer(post: post)).toList(),
        ],
      ),
    );
  }
}
