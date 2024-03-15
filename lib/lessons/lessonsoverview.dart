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
      future: checkIfLimitReached().then((limitReached) {
        if (limitReached) {
          // If limit is reached, show dialog and return an empty list to stop further processing
          Future.microtask(() => _showLimitReachedDialog(context));
          return []; // Return an empty list to prevent further processing
        } else {
          // If limit not reached, proceed with fetching lesson topics
          return FirestoreService().getLessonTopics();
        }
      }),
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
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg_02.jpg'),
                  fit: BoxFit.cover,
                  opacity: 1,
                ),
              ),
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20.0),
                crossAxisSpacing: 10.0,
                crossAxisCount: 2,
                children: lessontopics
                    .map((topic) => LessonTopicItem(lessontopic: topic))
                    .toList(),
              ),
            ),
            bottomNavigationBar: const BottomNavBar(initialIndex: 2),
          );
        }
        // Default return case
        return const SizedBox.shrink();
      },
    );
  }

  void _showLimitReachedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap button to close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Time Limit Reached"),
          content: const Text("You've reached your daily usage limit."),
          actions: <Widget>[
            TextButton(
              child: const Text('Return to Dashboard'),
              onPressed: () {
                // Navigate back to the dashboard screen
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }
}
