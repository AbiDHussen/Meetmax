import 'package:hive/hive.dart';
import 'comment.dart';

part 'post.g.dart';

@HiveType(typeId: 1)
class Post extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final String? imageUrl;

  @HiveField(3)
  final DateTime timestamp;

  @HiveField(4)
  final List<String> likes;

  @HiveField(5)
  final List<Comment> comments;

  @HiveField(6)
  final int shareCount; // ✅ Added field

  Post({
    required this.userId,
    required this.content,
    this.imageUrl,
    required this.timestamp,
    required this.likes,
    required this.comments,
    required this.shareCount, // ✅ Add this to constructor
  });
}
