import 'package:hive/hive.dart';
import 'package:meetmax/models/post.dart';
import 'package:meetmax/models/comment.dart';

class PostService {
  final Box<Post> postBox = Hive.box<Post>('posts');

  Future<void> createPost(Post post) async {
    await postBox.add(post);
  }

  Future<void> deleteAllPosts() async {
    await postBox.clear();
  }


  List<Post> getAllPosts() {
    return postBox.values.toList().reversed.toList(); // latest first
  }

  void toggleLike(Post post, String userId) {
    if (post.likes.contains(userId)) {
      post.likes.remove(userId);
    } else {
      post.likes.add(userId);
    }
    post.save();
  }

  void addComment(Post post, Comment comment) {
    post.comments.add(comment);
    post.save();
  }
}
