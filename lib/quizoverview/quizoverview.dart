import 'package:busybeelearning/quizoverview/drawer.dart';
import 'package:busybeelearning/quizoverview/topics_item.dart';
import 'package:flutter/material.dart';
import 'package:busybeelearning/services/services.dart';
import 'package:busybeelearning/shared/shared.dart';
import 'package:busybeelearning/colors.dart' as customcolor;

class QuizOverviewScreen extends StatelessWidget {
  const QuizOverviewScreen({super.key, Topic? topic});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(message: snapshot.error.toString()),
          );
        } else if (snapshot.hasData) {
          var topics = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
                title: const Text('Quiz Topics'),
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
                    gradient: customcolor.AppColor.customGradient,
                    boxShadow: [
                      // dark shadow bottom right
                      BoxShadow(
                        color: Colors.yellow.shade700,
                        offset: const Offset(0, 5),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                )),
            drawer: TopicDrawer(topics: topics),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: topics.map((topic) => TopicItem(topic: topic)).toList(),
            ),
            bottomNavigationBar: const BottomNavBar(initialIndex: 1),
          );
        } else {
          return const Text('No topics found in Firestore. Check database');
        }
      },
    );
  }
}
