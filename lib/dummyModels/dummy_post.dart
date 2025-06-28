import 'package:meetmax/dummyModels/dummy_comment.dart';

import 'dummy_user.dart';

class DummyPost {
  final DummyUser user;
  final String caption;
  final String timeAgo;
  final String imageUrl;
  final List<String> likes;
  final List<DummyComment> comments;
  final int shares;

  DummyPost({
    required this.user,
    required this.caption,
    required this.timeAgo,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}
