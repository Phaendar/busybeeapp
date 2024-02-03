import 'package:flutter/material.dart';
import 'package:busybeelearning/colors.dart' as customcolor;

import '../shared/shared.dart';

class MathsLessonsScreen extends StatelessWidget {
  const MathsLessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Maths Lessons',
            textAlign: TextAlign.center,
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  customcolor.AppColor.gradientFirst,
                  customcolor.AppColor.gradientSecond,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          )),
      body: ListView(
        children: const [
          LessonCard(
            title: 'Lesson 1',
            subtitle: 'Introduction to Flutter',
            materialColor: Colors.red,
          ),
          LessonCard(
            title: 'Lesson 2',
            subtitle: 'Widgets in Flutter',
            materialColor: Colors.blue,
          ),
          LessonCard(
            title: 'Lesson 3',
            subtitle: 'Layouts in Flutter',
            materialColor: Colors.green,
          ),
          LessonCard(
            title: 'Lesson 4',
            subtitle: 'Navigation in Flutter',
            materialColor: Colors.purple,
          ),
          LessonCard(
            title: 'Lesson 5',
            subtitle: 'State Management in Flutter',
            materialColor: Colors.orange,
          ),
          LessonCard(
            title: 'Lesson 6',
            subtitle: 'Flutter Packages',
            materialColor: Colors.yellow,
          ),
          LessonCard(
            title: 'Lesson 7',
            subtitle: 'Flutter Plugins',
            materialColor: Colors.pink,
          ),
          LessonCard(
            title: 'Lesson 8',
            subtitle: 'Flutter Testing',
            materialColor: Colors.teal,
          ),
          LessonCard(
            title: 'Lesson 9',
            subtitle: 'Flutter CI/CD',
            materialColor: Colors.brown,
          ),
          LessonCard(
            title: 'Lesson 10',
            subtitle: 'Flutter Animations',
            materialColor: Colors.blueGrey,
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(initialIndex: 2),
    );
  }
}

class LessonCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final MaterialColor materialColor;

  const LessonCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.materialColor});

  @override
  Card build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: materialColor,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
