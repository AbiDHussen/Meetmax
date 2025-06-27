import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meetmax/data/data.dart';
import 'package:meetmax/models/post.dart';
import 'package:meetmax/screens/feed_screen.dart';
import 'package:meetmax/services/post_service.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class MiddleSection extends StatefulWidget {
  final String visibility;
  final ValueChanged<String> onVisibilityChanged;

  const MiddleSection({
    super.key,
    required this.visibility,
    required this.onVisibilityChanged,
  });

  @override
  State<MiddleSection> createState() => _MiddleSectionState();
}

class _MiddleSectionState extends State<MiddleSection> {
  final TextEditingController _postController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final dir = await getApplicationDocumentsDirectory();
      final name = p.basename(picked.path); // ✅ use p.basename
      final saved = await File(picked.path).copy('${dir.path}/$name');

      setState(() {
        _selectedImage = saved;
      });
    }
  }

  void _handlePost() async {
    final content = _postController.text.trim();
    if (content.isEmpty && _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post content or image required')),
      );
      return;
    }

    final authBox = Hive.box('auth');
    final currentEmail = authBox.get('currentUserEmail');

    if (currentEmail == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No logged in user found')),
      );
      return;
    }

    final newPost = Post(
      userId: currentEmail,
      content: content,
      imageUrl: _selectedImage?.path,
      timestamp: DateTime.now(),
      likes: [],
      comments: [],
      shareCount: 0,
    );

    await PostService().createPost(newPost);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post created successfully')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const FeedPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87, size: 24),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 10),
              const Text('Create a post',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87)),
              const Spacer(),
              const Text('Visible for', style: TextStyle(fontSize: 13, color: Colors.grey)),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: widget.visibility,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.blue),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.grey, size: 20),
                    borderRadius: BorderRadius.circular(8),
                    dropdownColor: Colors.white,
                    items: ['Public', 'Friends', 'Only me'].map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        widget.onVisibilityChanged(newValue);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          child: const Divider(thickness: 0.8),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input area
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(currentUser.imageUrl),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _postController,
                        maxLines: 6,
                        decoration: const InputDecoration(
                          hintText: "What’s happening?",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              if (_selectedImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(_selectedImage!, height: 180),
                ),

              const SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.videocam_outlined, color: Colors.black87),
                title: const Text("Live Video"),
                dense: true,
                visualDensity: VisualDensity.compact,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.photo_library_outlined, color: Colors.black87),
                title: const Text("Photo/Video"),
                onTap: _pickImage,
                dense: true,
                visualDensity: VisualDensity.compact,
              ),
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.emoji_emotions_outlined, color: Colors.black87),
                title: Text("Feeling"),
                dense: true,
                visualDensity: VisualDensity.compact,
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: _handlePost,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text("Post", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
