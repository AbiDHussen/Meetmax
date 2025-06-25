import 'dummy_user.dart';

class DummyStory {
  final DummyUser user;
  final String imageUrl;
  final bool isViewed;

  DummyStory({
    required this.user,
    required this.imageUrl,
    this.isViewed = false,
  });
}
