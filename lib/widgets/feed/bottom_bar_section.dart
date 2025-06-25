import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBarSection extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomBarSection({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BottomBarSection> createState() => _BottomBarSectionState();
}

class _BottomBarSectionState extends State<BottomBarSection> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white, // White background
      elevation: 0, // Removes top shadow/gap
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      selectedItemColor: Colors.blue[800],
      unselectedItemColor: Colors.black54,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: [
        const BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.thLarge),
          label: 'Feed',
        ),
        const BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.userFriends),
          label: 'My community',
        ),
        const BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.compass),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              const FaIcon(FontAwesomeIcons.bell),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          label: 'Notification',
        ),
        const BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.gear),
          label: 'Settings',
        ),
      ],
    );
  }
}
