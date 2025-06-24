import 'package:flutter/material.dart';
import 'package:meetmax/data/data.dart';
import 'package:meetmax/widgets/create_post_container.dart';
import 'package:meetmax/widgets/post_container.dart';
import 'package:meetmax/widgets/stories_section.dart';
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
          // 🔹 Top bar
          TopBarSection(currentUser: currentUser),

          // 🔹 Soft divider
          const SizedBox(height: 10),
          Container(
            height: 10,
            color: Colors.grey.shade50,
          ),
          const SizedBox(height: 10),

          // 🔹 Stories
          StoriesSection(stories: stories),

          // 🔹 Soft divider
          const SizedBox(height: 10),
          Container(
            height: 10,
            color: Colors.grey.shade50,
          ),
          const SizedBox(height: 10),

          // 🔹 Create Post
          CreatePostContainer(currentUser: currentUser),

          // 🔹 Optional bottom divider
          const SizedBox(height: 10),
          Container(
            height: 10,
            color: Colors.grey.shade50,
          ),
          
          PostContainer(posts: posts)
        ],
      ),
    );
  }
}
