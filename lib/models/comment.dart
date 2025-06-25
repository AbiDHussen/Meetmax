import 'package:hive/hive.dart';

part 'comment.g.dart';

@HiveType(typeId: 3)
class Comment extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String text;

  @HiveField(2)
  final DateTime timestamp;

  Comment({
    required this.userId,
    required this.text,
    required this.timestamp,
  });
}
