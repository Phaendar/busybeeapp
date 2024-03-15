import 'package:flutter/material.dart';
import 'package:busybeelearning/services/services.dart';
import 'package:busybeelearning/shared/shared.dart';
import 'package:busybeelearning/colors.dart' as customcolor;
import 'package:busybeelearning/quizoverview/drawer.dart';
import 'package:busybeelearning/quizoverview/topics_item.dart';

class QuizOverviewScreen extends StatelessWidget {
  const QuizOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
      future: checkIfLimitReached().then((limitReached) {
        if (limitReached) {
          // If limit is reached, show dialog and return an empty list to stop further processing
          Future.microtask(() => _showLimitReachedDialog(context));
          return <Topic>[]; // Return an empty list to prevent further processing
        } else {
          // If limit not reached, proceed with fetching quiz topics
          return FirestoreService().getTopics();
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
                    BoxShadow(
                      color: Colors.yellow.shade700,
                      offset: const Offset(0, 5),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
              ),
            ),
            drawer: TopicDrawer(topics: topics),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg_02.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20.0),
                crossAxisSpacing: 10.0,
                crossAxisCount: 2,
                children:
                    topics.map((topic) => TopicItem(topic: topic)).toList(),
              ),
            ),
            bottomNavigationBar: const BottomNavBar(initialIndex: 1),
          );
        } else {
          // Handle the case where no data is returned
          return const Text('No topics found in Firestore. Check database');
        }
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
