// 🛠️ Add fallback logic to images for profile and post images

import 'package:flutter/material.dart';
import 'package:meetmax/models/comment.dart';
import 'package:meetmax/models/post.dart';
import 'package:meetmax/models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetmax/services/user_service.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:hive/hive.dart';
import 'dart:io';

class RealPostContainer extends StatelessWidget {
  final List<Post> posts;

  const RealPostContainer({super.key, required this.posts});

  User get defaultUser => User(
    name: 'Unknown User',
    email: 'unknown@example.com',
    imageUrl: '', // Keep empty to trigger fallback
    gender: 'N/A',
    birthDate: DateTime(2000, 1, 1),
    password: '',
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        posts.length,
            (index) => Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : 8, bottom: 8),
          child: _PostCard(post: posts[index], defaultUser: defaultUser),
        ),
      ),
    );
  }
}

class _PostCard extends StatefulWidget {
  final Post post;
  final User defaultUser;

  const _PostCard({required this.post, required this.defaultUser});

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  late Post post;
  late User user;
  String? currentUserEmail;

  @override
  void initState() {
    super.initState();
    post = widget.post;
    user = UserService().getUserById(post.userId) ?? widget.defaultUser;
    final authBox = Hive.box('auth');
    currentUserEmail = authBox.get('currentUserEmail');
  }

  void _toggleLike() {
    if (currentUserEmail == null) return;

    setState(() {
      if (post.likes.contains(currentUserEmail)) {
        post.likes.remove(currentUserEmail);
      } else {
        post.likes.add(currentUserEmail!);
      }
      post.save();
    });
  }

  void _showCommentsBottomSheet(BuildContext context) {
    final TextEditingController _commentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: 400,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text('Comments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Expanded(
                  child: post.comments.isEmpty
                      ? const Center(child: Text("No comments yet."))
                      : ListView.builder(
                    itemCount: post.comments.length,
                    itemBuilder: (context, index) {
                      final comment = post.comments[index];
                      final commentUser = UserService().getUserById(comment.userId) ?? widget.defaultUser;
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: commentUser.imageUrl.isNotEmpty
                              ? NetworkImage(commentUser.imageUrl)
                              : const AssetImage('assets/images/default_user.png') as ImageProvider,
                        ),
                        title: Text(commentUser.name),
                        subtitle: Text(comment.text),
                        trailing: Text(
                          timeago.format(comment.timestamp),
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(hintText: 'Add a comment...'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        final commentText = _commentController.text.trim();
                        if (commentText.isEmpty || currentUserEmail == null) return;

                        setState(() {
                          post.comments.add(Comment(
                            userId: currentUserEmail!,
                            text: commentText,
                            timestamp: DateTime.now(),
                          ));
                          post.save();
                        });

                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              child: Image.file(File(post.imageUrl!)),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
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
                    child: TextButton.icon(
                      onPressed: _toggleLike,
                      icon: FaIcon(
                        FontAwesomeIcons.heart,
                        color: post.likes.contains(currentUserEmail)
                            ? Colors.red
                            : Colors.grey[700],
                        size: 20,
                      ),
                      label: Text("Like", style: TextStyle(color: Colors.grey[700])),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton.icon(
                      onPressed: () => _showCommentsBottomSheet(context),
                      icon: FaIcon(FontAwesomeIcons.comment, size: 20, color: Colors.grey[700]),
                      label: Text("Comment", style: TextStyle(color: Colors.grey[700])),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.share, size: 20, color: Colors.grey[700]),
                      label: Text("Share", style: TextStyle(color: Colors.grey[700])),
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
}

class _PostHeader extends StatelessWidget {
  final User user;
  final String timeAgo;

  const _PostHeader({required this.user, required this.timeAgo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: user.imageUrl.isNotEmpty
              ? NetworkImage(user.imageUrl)
              : const AssetImage('assets/images/default_user.png') as ImageProvider,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("$timeAgo · Public", style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        const Spacer(),
        const Icon(Icons.more_horiz),
      ],
    );
  }
}
