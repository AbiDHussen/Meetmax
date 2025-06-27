import 'package:flutter/material.dart';
import 'package:meetmax/models/post.dart';
import 'package:meetmax/models/models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostContainer extends StatelessWidget {
  final List<DummyPost> posts;

  const PostContainer({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        posts.length,
            (index) => Container(
          margin: EdgeInsets.only(
            top: index == 0 ? 0 : 8,
            bottom: 8,
          ),
          child: _buildPostCard(posts[index]),
        ),
      ),
    );
  }

  Widget _buildPostCard(DummyPost post) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PostHeader(user: post.user, timeAgo: post.timeAgo),
          const SizedBox(height: 10),
          if (post.caption.isNotEmpty)
            Text(post.caption, style: const TextStyle(fontSize: 16)),
          if (post.imageUrl.isNotEmpty) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(post.imageUrl),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 6),
              Text(
                "${post.likes.length} Likes",
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const Spacer(),
              Text(
                "${post.comments.length} Comments",
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(width: 12),
              Text(
                "${post.shares} Shares",
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Divider(thickness: 0.7, height: 1),
          SizedBox(
            height: 35,
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: _buildPostButton(
                      FontAwesomeIcons.heart,
                      "Like",
                      isFaIcon: true,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: _buildPostButton(
                      FontAwesomeIcons.comment,
                      "Comment",
                      isFaIcon: true,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: _buildPostButton(
                      FontAwesomeIcons.share,
                      "Share",
                      isFaIcon: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 0.7, height: 1),
        ],
      ),
    );
  }

  Widget _buildPostButton(
      IconData icon,
      String label, {
        bool isFaIcon = false,
      }) {
    return TextButton.icon(
      onPressed: () {},
      icon: isFaIcon
          ? FaIcon(icon, color: Colors.grey[700], size: 20)
          : Icon(icon, color: Colors.grey[700], size: 20),
      label: Text(label, style: TextStyle(color: Colors.grey[700])),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final DummyUser user;
  final String timeAgo;

  const _PostHeader({required this.user, required this.timeAgo});

  @override
  Widget build(BuildContext context) {

    //  Print all user info for debugging
    // debugPrint('🔍 User Info:');
    // debugPrint('Name: ${user.name}');
    // debugPrint('Email: ${user.email}');
    // debugPrint('Image URL: ${user.imageUrl}');
    // debugPrint('Birthdate: ${user.birthDate}');
    // debugPrint('Gender: ${user.gender}');

    return Row(
      children: [
        CircleAvatar(backgroundImage: NetworkImage(user.imageUrl)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "$timeAgo · Public",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        const Icon(Icons.more_horiz),
      ],
    );
  }
}
