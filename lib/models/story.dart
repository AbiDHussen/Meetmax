import 'package:hive/hive.dart';
import 'package:meetmax/models/user.dart';

part 'story.g.dart';

@HiveType(typeId: 2)
class Story extends HiveObject {
  @HiveField(0)
  final User user;

  @HiveField(1)
  final String imageUrl;

  @HiveField(2)
  final bool isViewed;

  Story({
    required this.user,
    required this.imageUrl,
    this.isViewed = false,
  });
}
