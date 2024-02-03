import 'package:busybeelearning/lessons/geographylessons.dart';
import 'package:busybeelearning/lessons/historylessons.dart';
import 'package:busybeelearning/lessons/mathslessons.dart';
import 'package:busybeelearning/shared/neu_box.dart';
import 'package:flutter/material.dart';
import 'package:busybeelearning/services/services.dart';
import 'package:busybeelearning/services/models.dart';

class LessonTopicItem extends StatelessWidget {
  final LessonTopic lessontopic;
  const LessonTopicItem({super.key, required this.lessontopic});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: lessontopic.img,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NeuBox(
          child: InkWell(
            onTap: () {
              if (lessontopic.title == 'Geography') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const GeographyLessonsScreen(),
                  ),
                );
              } else if (lessontopic.title == 'History') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const HistoryLessonsScreen(),
                  ),
                );
              } else if (lessontopic.title == 'Maths') {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const MathsLessonsScreen(),
                  ),
                );
              }
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
                        'assets/covers/${lessontopic.img}',
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
                      lessontopic.title,
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
                const Flexible(
                  child: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
