import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meetmax/dummyModels/models.dart';
import 'package:meetmax/services/user_service.dart';

class StoriesSection extends StatelessWidget {
  final List<DummyStory> stories;

  const StoriesSection({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    final authBox = Hive.box('auth');
    final currentUserEmail = authBox.get('currentUserEmail');
    final currentUser = currentUserEmail != null
        ? UserService().getUserById(currentUserEmail)
        : null;

    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final story = stories[index];
          final isFirst = index == 0;

          final String displayName = isFirst
              ? (currentUser?.name ?? 'You')
              : (story.user.name ?? 'User');

          final String imageUrl = story.user.imageUrl;

          return Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blueAccent, width: 2),
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(strokeWidth: 2),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                  ),
                  if (isFirst)
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add_circle,
                          color: Colors.blue,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                displayName,
                style: const TextStyle(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }
}
