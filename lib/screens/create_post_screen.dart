import 'package:flutter/material.dart';
import 'package:meetmax/data/data.dart';
import 'package:meetmax/widgets/feed/bottom_bar_section.dart';
import 'package:meetmax/widgets/feed/top_bar_section.dart';
import 'package:meetmax/widgets/createPost/middle_section.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String visibility = 'Friends';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                //Top section
                TopBarSection(currentUser: currentUser),

                //Middle section
                MiddleSection(
                  visibility: visibility,
                  onVisibilityChanged: (value) {
                    setState(() {
                      visibility = value;
                    });
                  },
                ),
              ],
            ),
          ),

          //Bottom Section
          BottomBarSection(currentIndex: 0, onTap: (int index) {}),
        ],
      ),
    );
  }
}
