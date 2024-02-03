import 'package:busybeelearning/shared/neu_box.dart';
import 'package:flutter/material.dart';
import 'package:busybeelearning/services/models.dart';
import 'package:busybeelearning/shared/progress_bar.dart';
import 'package:busybeelearning/quizoverview/drawer.dart';
import 'package:busybeelearning/colors.dart' as customcolor;

class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: topic.img,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeuBox(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => TopicScreen(topic: topic),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/covers/${topic.img}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      textAlign: TextAlign.center,
                      topic.title,
                      style: const TextStyle(
                        color: Colors.black,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                ),
                Flexible(child: TopicProgress(topic: topic)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopicScreen extends StatelessWidget {
  final Topic topic;

  const TopicScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: customcolor.AppColor.customGradient,
          ),
        ),
      ),
      body: ListView(children: [
        Hero(
          tag: topic.img,
          child: Image.asset('assets/covers/${topic.img}',
              width: MediaQuery.of(context).size.width),
        ),
        Text(
          topic.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            height: 2,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        QuizList(topic: topic)
      ]),
    );
  }
}
