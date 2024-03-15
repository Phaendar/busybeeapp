import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for rootBundle
import 'package:busybeelearning/colors.dart' as customcolor;
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../services/services.dart';
import '../shared/shared.dart';
import 'dart:convert';

class LessonDetailsScreen extends StatefulWidget {
  final Lesson lesson;
  const LessonDetailsScreen({super.key, required this.lesson});

  @override
  LessonDetailsScreenState createState() => LessonDetailsScreenState();
}

class LessonDetailsScreenState extends State<LessonDetailsScreen> {
  late final ChewieController _chewieController;
  String? lessonText;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController:
          VideoPlayerController.asset(widget.lesson.videoAssetPath),
      aspectRatio: 16 / 9,
      autoPlay: false,
      looping: false,
    );
    _loadLessonText();
  }

  _loadLessonText() async {
    String jsonData = await rootBundle.loadString(widget.lesson.content);
    Map<String, dynamic> lessonData = jsonDecode(jsonData);
    setState(() {
      lessonText = lessonData["content"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.lesson.title,
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
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.lesson.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Chewie(controller: _chewieController)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(lessonText ?? 'Loading lesson content...'),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(initialIndex: 2),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
  }
}
