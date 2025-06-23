import 'package:flutter/material.dart';
import 'package:meetmax/models/post.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(post.user.imageUrl)),
            title: Text(post.user.name, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(post.timeAgo),
            trailing: const Icon(Icons.more_horiz),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(post.caption),
          ),
          if (post.imageUrl.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Image.network(post.imageUrl),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('👍 ${post.likes}'),
                Text('${post.comments} Comments · ${post.shares} Shares'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
