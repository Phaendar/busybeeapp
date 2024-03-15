import 'package:busybeelearning/dashboard/dashboard.dart';
import 'package:busybeelearning/lessons/lessonsoverview.dart';
import 'package:busybeelearning/notes/notes.dart';
import 'package:busybeelearning/profile/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:busybeelearning/quizoverview/quizoverview.dart';

class BottomNavBar extends StatefulWidget {
  final int initialIndex;

  const BottomNavBar({super.key, this.initialIndex = 0});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
        break;
      case 1:
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const QuizOverviewScreen()));
        break;
      case 2:
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const LessonsOverviewScreen()));
        break;
      case 3:
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NotesScreen()));
        break;
      case 4:
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: _currentIndex,
      onTap: _navigateBottomBar,
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: const Color.fromRGBO(228, 217, 189, 1.0),
      buttonBackgroundColor: Colors.yellow.shade600,
      color: const Color.fromARGB(255, 255, 196, 0),
      height: 55,
      items: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                // dark shadow bottom right
                BoxShadow(
                  color: Colors.yellow.shade700,
                  offset: const Offset(5, 5),
                  blurRadius: 10,
                ),
                // light shadow top left
                BoxShadow(
                  color: Colors.yellow.shade200,
                  offset: const Offset(-5, -5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(Icons.home)),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                // dark shadow bottom right
                BoxShadow(
                  color: Colors.yellow.shade700,
                  offset: const Offset(5, 5),
                  blurRadius: 10,
                ),
                // light shadow top left
                BoxShadow(
                  color: Colors.yellow.shade200,
                  offset: const Offset(-5, -5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(Icons.quiz_rounded)),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                // dark shadow bottom right
                BoxShadow(
                  color: Colors.yellow.shade700,
                  offset: const Offset(5, 5),
                  blurRadius: 10,
                ),
                // light shadow top left
                BoxShadow(
                  color: Colors.yellow.shade200,
                  offset: const Offset(-5, -5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(Icons.play_lesson_rounded)),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                // dark shadow bottom right
                BoxShadow(
                  color: Colors.yellow.shade700,
                  offset: const Offset(5, 5),
                  blurRadius: 10,
                ),
                // light shadow top left
                BoxShadow(
                  color: Colors.yellow.shade200,
                  offset: const Offset(-5, -5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(Icons.note)),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                // dark shadow bottom right
                BoxShadow(
                  color: Colors.yellow.shade700,
                  offset: const Offset(5, 5),
                  blurRadius: 10,
                ),
                // light shadow top left
                BoxShadow(
                  color: Colors.yellow.shade200,
                  offset: const Offset(-5, -5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(Icons.person)),
      ],
    );
  }
}
