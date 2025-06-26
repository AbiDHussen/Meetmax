import 'package:flutter/material.dart';
import 'package:meetmax/models/post.dart';
import 'package:meetmax/models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetmax/services/user_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class RealPostContainer extends StatelessWidget {
  final List<Post> posts;

  const RealPostContainer({super.key, required this.posts});

  // Define default user in case the actual user is not found
  User get defaultUser => User(
    name: 'Unknown User',
    email: 'unknown@example.com',
    imageUrl: 'https://via.placeholder.com/150',
    gender: 'N/A',
    birthDate: DateTime(2000, 1, 1), password: '',
  );

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

  Widget _buildPostCard(Post post) {
    final User user = UserService().getUserById(post.userId) ?? defaultUser;

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
          _PostHeader(user: user, timeAgo: timeago.format(post.timestamp)),
          const SizedBox(height: 10),
          if (post.content.isNotEmpty)
            Text(post.content, style: const TextStyle(fontSize: 16)),
          if (post.imageUrl != null && post.imageUrl!.isNotEmpty) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(post.imageUrl!),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              const Row(
                children: [
                  FaIcon(FontAwesomeIcons.solidHeart, size: 18, color: Colors.red),
                  SizedBox(width: 4),
                  FaIcon(FontAwesomeIcons.faceGrinHearts, size: 18, color: Colors.orange),
                  SizedBox(width: 4),
                  FaIcon(FontAwesomeIcons.thumbsUp, size: 18, color: Colors.blue),
                ],
              ),
              const SizedBox(width: 6),
              Text(
                "${post.likes.length}",
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const Spacer(),
              Text(
                "${post.comments.length} Comments",
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(width: 12),
              Text(
                "${post.shareCount} Shares",
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
  final User user;
  final String timeAgo;

  const _PostHeader({required this.user, required this.timeAgo});

  @override
  Widget build(BuildContext context) {
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
