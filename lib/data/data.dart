import 'package:meetmax/models/dummy_post.dart';
import 'package:meetmax/models/dummy_user.dart';
import 'package:meetmax/models/dummy_comment.dart';
import 'package:meetmax/models/dummy_story.dart';

// Dummy users
final DummyUser currentUser = DummyUser(
  name: 'Marcus Ng',
  email: 'marcus@gmail.com',
  password: 'marcus123',
  imageUrl:
  'https://images.unsplash.com/photo-1578133671540-edad0b3d689e?auto=format&fit=crop&w=1351&q=80',
  birthDate: DateTime(1990, 5, 14),
  gender: 'Male',
);

final List<DummyUser> onlineUsers = [
  DummyUser(
    name: 'David Brooks',
    email: 'david.brooks@example.com',
    password: 'password123',
    imageUrl:
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=634&q=80',
    birthDate: DateTime(1990, 5, 14),
    gender: 'Male',
  ),
  DummyUser(
    name: 'Jane Doe',
    email: 'jane.doe@example.com',
    password: 'securePass456',
    imageUrl:
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=634&q=80',
    birthDate: DateTime(1995, 8, 21),
    gender: 'Female',
  ),
  DummyUser(
    name: 'Amy Smith',
    email: 'amy.smith@example.com',
    password: 'amysmith123',
    imageUrl:
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=700&q=80',
    birthDate: DateTime(1993, 12, 5),
    gender: 'Female',
  ),
  DummyUser(
    name: 'Paul Pinnock',
    email: 'paul.pinnock@example.com',
    password: 'pinnockPW',
    imageUrl:
    'https://images.unsplash.com/photo-1519631128182-433895475ffe?auto=format&fit=crop&w=1350&q=80',
    birthDate: DateTime(1989, 7, 9),
    gender: 'Male',
  ),
  DummyUser(
    name: 'Elizabeth Wong',
    email: 'elizabeth.wong@example.com',
    password: 'wongStrong!',
    imageUrl:
    'https://images.unsplash.com/photo-1515077678510-ce3bdf418862?auto=format&fit=crop&w=675&q=80',
    birthDate: DateTime(1994, 3, 3),
    gender: 'Female',
  ),
];

// Likes
List<String> allUsernames = [
  currentUser.name,
  ...onlineUsers.map((user) => user.name),
];

// Comments
final List<DummyComment> sampleComments = [
  DummyComment(
    userId: 'Jane Doe',
    text: 'Amazing photo!',
    timestamp: DateTime.now().subtract(Duration(minutes: 10)),
  ),
  DummyComment(
    userId: 'David Brooks',
    text: 'Looks great!',
    timestamp: DateTime.now().subtract(Duration(hours: 1)),
  ),
  DummyComment(
    userId: 'Amy Smith',
    text: 'What a view 😍',
    timestamp: DateTime.now().subtract(Duration(hours: 2)),
  ),
  DummyComment(
    userId: 'Paul Pinnock',
    text: 'Nice one!',
    timestamp: DateTime.now().subtract(Duration(hours: 3)),
  ),
  DummyComment(
    userId: 'Elizabeth Wong',
    text: 'So cool!',
    timestamp: DateTime.now().subtract(Duration(hours: 4)),
  ),
  DummyComment(
    userId: 'Marcus Ng',
    text: 'Wow, love this!',
    timestamp: DateTime.now().subtract(Duration(hours: 5)),
  ),
];

// Posts
final List<DummyPost> dummyPosts = [
  DummyPost(
    user: currentUser,
    caption: 'Just enjoying some sunshine ☀️',
    timeAgo: '2h',
    imageUrl: 'https://images.unsplash.com/photo-1525253086316-d0c936c814f8?auto=format&fit=crop&w=1350&q=80',
    likes: allUsernames.sublist(0, 5),
    comments: sampleComments.sublist(0, 3),
    shares: 10,
  ),
  DummyPost(
    user: onlineUsers[0],
    caption: 'Chillin’ by the beach 🌊',
    timeAgo: '5h',
    imageUrl: 'https://images.unsplash.com/photo-1573331519317-30b24326bb9a?auto=format&fit=crop&w=1350&q=80',
    likes: allUsernames.sublist(1, 6),
    comments: sampleComments.sublist(1, 4),
    shares: 8,
  ),
  DummyPost(
    user: onlineUsers[1],
    caption: 'Adventure time in the mountains 🏞',
    timeAgo: '1d',
    imageUrl: 'https://images.unsplash.com/photo-1575535468632-345892291673?auto=format&fit=crop&w=634&q=80',
    likes: allUsernames.sublist(0, 5),
    comments: sampleComments.sublist(2, 5),
    shares: 15,
  ),
];

// Stories
final List<DummyStory> stories = [
  DummyStory(user: currentUser, imageUrl: currentUser.imageUrl),
  DummyStory(
    user: onlineUsers[2],
    imageUrl: 'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?auto=format&fit=crop&w=1400&q=80',
  ),
  DummyStory(
    user: onlineUsers[3],
    imageUrl: 'https://images.unsplash.com/photo-1499363536502-87642509e31b?auto=format&fit=crop&w=634&q=80',
    isViewed: true,
  ),
  DummyStory(
    user: onlineUsers[1],
    imageUrl: 'https://images.unsplash.com/photo-1497262693247-aa258f96c4f5?auto=format&fit=crop&w=624&q=80',
  ),
  DummyStory(
    user: onlineUsers[4],
    imageUrl: 'https://images.unsplash.com/photo-1496950866446-3253e1470e8e?auto=format&fit=crop&w=1350&q=80',
    isViewed: true,
  ),
  DummyStory(
    user: onlineUsers[0],
    imageUrl: 'https://images.unsplash.com/photo-1475688621402-4257c812d6db?auto=format&fit=crop&w=1267&q=80',
  ),
  DummyStory(
    user: onlineUsers[2],
    imageUrl: 'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?auto=format&fit=crop&w=1400&q=80',
  ),
  DummyStory(
    user: onlineUsers[3],
    imageUrl: 'https://images.unsplash.com/photo-1499363536502-87642509e31b?auto=format&fit=crop&w=634&q=80',
    isViewed: true,
  ),
  DummyStory(
    user: onlineUsers[1],
    imageUrl: 'https://images.unsplash.com/photo-1497262693247-aa258f96c4f5?auto=format&fit=crop&w=624&q=80',
  ),
  DummyStory(
    user: onlineUsers[4],
    imageUrl: 'https://images.unsplash.com/photo-1496950866446-3253e1470e8e?auto=format&fit=crop&w=1350&q=80',
    isViewed: true,
  ),
  DummyStory(
    user: onlineUsers[0],
    imageUrl: 'https://images.unsplash.com/photo-1475688621402-4257c812d6db?auto=format&fit=crop&w=1267&q=80',
  ),
];
