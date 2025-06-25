// lib/services/story_service.dart
import 'package:hive/hive.dart';
import '../models/story.dart';

class StoryService {
  final Box<Story> storyBox = Hive.box<Story>('stories');

  List<Story> getAllStories() => storyBox.values.toList();

  Future<void> addStory(Story story) async {
    await storyBox.add(story);
  }

  Future<void> deleteStory(int index) async {
    await storyBox.deleteAt(index);
  }

  Future<void> updateStory(int index, Story updatedStory) async {
    await storyBox.putAt(index, updatedStory);
  }
}
