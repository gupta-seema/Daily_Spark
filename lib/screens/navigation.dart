import 'package:flutter/material.dart';
import 'home_screens.dart';
import 'affirmations_screen.dart';
import 'vision_board_screen.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    AffirmationsScreen(),
    VisionBoardScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Mood'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Affirmations'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Vision Board'),
        ],
      ),
    );
  }
}
