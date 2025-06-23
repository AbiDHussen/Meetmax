import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meetmax/models/user.dart';

class TopBarSection extends StatelessWidget {
  final User currentUser;

  const TopBarSection({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          // Dynamic Profile Picture
          CircleAvatar(
            radius: 22.0,
            backgroundColor: Colors.grey[200],
            backgroundImage: CachedNetworkImageProvider(currentUser.imageUrl),
          ),

          const SizedBox(width: 12),

          // Search Box
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Row(
                children: const [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Search for something here...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Chat Icon
          IconButton(
            onPressed: () {
              // TODO: Navigate to chat
            },
            icon: const Icon(Icons.message_outlined, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
