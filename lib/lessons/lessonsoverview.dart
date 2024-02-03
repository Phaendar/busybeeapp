import 'package:flutter/material.dart';
import 'package:busybeelearning/colors.dart' as customcolor;
import 'package:busybeelearning/lessons/lesson_topics_item.dart';
import 'package:busybeelearning/services/services.dart';
import '../shared/shared.dart';

class LessonsOverviewScreen extends StatelessWidget {
  final LessonTopic? lessontopic;

  const LessonsOverviewScreen({super.key, this.lessontopic});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LessonTopic>>(
      future: FirestoreService().getLessonTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var lessontopics = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
                title: const Text(
                  'Lesson Topics',
                  textAlign: TextAlign.center,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.library_music),
                    onPressed: () {
                      Navigator.pushNamed(context, '/musicplayer');
                    },
                  ),
                ],
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      // dark shadow bottom right
                      BoxShadow(
                        color: Colors.yellow.shade700,
                        offset: const Offset(0, 5),
                        blurRadius: 10.0,
                      ),
                    ],
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
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: lessontopics
                  .map((topic) => LessonTopicItem(lessontopic: topic))
                  .toList(),
            ),
            bottomNavigationBar: const BottomNavBar(initialIndex: 2),
          );
        }

        // Default return case, ideally should not reach here
        return const SizedBox.shrink();
      },
    );
  }
}
