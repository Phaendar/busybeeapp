import 'package:busybeelearning/lessons/lessondetails.dart';
import 'package:busybeelearning/services/services.dart';
import 'package:flutter/material.dart';
import 'package:busybeelearning/colors.dart' as customcolor;

import '../shared/shared.dart';

class GeographyLessonsScreen extends StatelessWidget {
  const GeographyLessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Geography Lessons',
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
            lessonKey: 'lesson01',
            title: 'Lesson 1',
            subtitle: 'Mountains',
            materialColor: Colors.red,
          ),
          LessonCard(
            lessonKey: 'lesson02',
            title: 'Lesson 2',
            subtitle: 'Rivers',
            materialColor: Colors.blue,
          ),
          LessonCard(
            lessonKey: 'lesson03',
            title: 'Lesson 3',
            subtitle: 'Maps',
            materialColor: Colors.green,
          ),
          LessonCard(
            lessonKey: 'lesson04',
            title: 'Lesson 4',
            subtitle: 'Flags',
            materialColor: Colors.purple,
          ),
          LessonCard(
            lessonKey: 'lesson05',
            title: 'Lesson 5',
            subtitle: 'Countries',
            materialColor: Colors.orange,
          ),
          LessonCard(
            lessonKey: 'lesson06',
            title: 'Lesson 6',
            subtitle: 'Lesson 6 Subtitle',
            materialColor: Colors.yellow,
          ),
          LessonCard(
            lessonKey: 'lesson07',
            title: 'Lesson 7',
            subtitle: 'Lesson 7 Subtitle',
            materialColor: Colors.pink,
          ),
          LessonCard(
            lessonKey: 'lesson08',
            title: 'Lesson 8',
            subtitle: 'Lesson 8 Subtitle',
            materialColor: Colors.teal,
          ),
          LessonCard(
            lessonKey: 'lesson09',
            title: 'Lesson 9',
            subtitle: 'Lesson 9 Subtitle',
            materialColor: Colors.brown,
          ),
          LessonCard(
            lessonKey: 'lesson10',
            title: 'Lesson 10',
            subtitle: 'Lesson 10 Subtitle',
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
  final String lessonKey;

  const LessonCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.materialColor,
      required this.lessonKey});

  @override
  Card build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  LessonDetailsScreen(lesson: lessonsMap[lessonKey]!),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundColor: materialColor,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

Map<String, Lesson> lessonsMap = {
  'lesson01': Lesson(
    title: "Geography Lesson 01",
    videoAssetPath: "lib/lessons/geography/lesson01/video.mp4",
    content: "lib/lessons/geography/lesson01/content.json",
  ),
  'lesson02': Lesson(
    title: "Geography Lesson 02",
    videoAssetPath: "lessons/geography/lesson02/video.mp4",
    content: "lessons/geography/lesson02/content.json",
  ),
  'lesson03': Lesson(
    title: "Geography Lesson 03",
    videoAssetPath: "lessons/geography/lesson03/video.mp4",
    content: "lessons/geography/lesson03/content.json",
  ),
  'lesson04': Lesson(
    title: "Geography Lesson 04",
    videoAssetPath: "lessons/geography/lesson04/video.mp4",
    content: "lessons/geography/lesson04/content.json",
  ),
  'lesson05': Lesson(
    title: "Geography Lesson 05",
    videoAssetPath: "lessons/geography/lesson05/video.mp4",
    content: "lessons/geography/lesson05/content.json",
  ),
  'lesson06': Lesson(
    title: "Geography Lesson 06",
    videoAssetPath: "lessons/geography/lesson06/video.mp4",
    content: "lessons/geography/lesson06/content.json",
  ),
  'lesson07': Lesson(
    title: "Geography Lesson 07",
    videoAssetPath: "lessons/geography/lesson07/video.mp4",
    content: "lessons/geography/lesson07/content.json",
  ),
  'lesson08': Lesson(
    title: "Geography Lesson 08",
    videoAssetPath: "lessons/geography/lesson08/video.mp4",
    content: "lessons/geography/lesson08/content.json",
  ),
  'lesson09': Lesson(
    title: "Geography Lesson 09",
    videoAssetPath: "lessons/geography/lesson09/video.mp4",
    content: "lessons/geography/lesson09/content.json",
  ),
  'lesson10': Lesson(
    title: "Geography Lesson 10",
    videoAssetPath: "lessons/geography/lesson10/video.mp4",
    content: "lessons/geography/lesson10/content.json",
  ),
};
