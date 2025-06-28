import 'package:flutter/material.dart';
import 'package:meetmax/data/data.dart';
import 'package:meetmax/models/post.dart';
import 'package:meetmax/services/post_service.dart';
import 'package:meetmax/widgets/feed/bottom_bar_section.dart';
import 'package:meetmax/widgets/feed/create_post_container.dart';
import 'package:meetmax/widgets/feed/dummy_post_container.dart';
import 'package:meetmax/widgets/feed/real_post_container.dart';
import 'package:meetmax/widgets/feed/stories_section.dart';
import 'package:meetmax/widgets/feed/top_bar_section.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PostService postService = PostService();
    final List<Post> realPosts = postService.getAllPosts();

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          // Top bar
          TopBarSection(currentUser: currentUser),

          const SizedBox(height: 10),
          Container(height: 10, color: Colors.grey.shade50),
          const SizedBox(height: 10),

          // Stories
          StoriesSection(stories: stories),

          const SizedBox(height: 10),
          Container(height: 10, color: Colors.grey.shade50),
          const SizedBox(height: 10),

          // Create Post
          CreatePostContainer(currentUser: currentUser),

          const SizedBox(height: 10),
          Container(height: 10, color: Colors.grey.shade50),

          // Real Posts from Hive
          if (realPosts.isNotEmpty) RealPostContainer(posts: realPosts),

          // Dummy Posts
          DummyPostContainer(posts: dummyPosts),

          const SizedBox(height: 12),

          //Bottom Bar
          BottomBarSection(currentIndex: 0, onTap: (int index) {}),
        ],
      ),
    );
  }
}
