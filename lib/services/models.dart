import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Option {
  String value;
  String detail;
  bool correct;
  Option({this.value = '', this.detail = '', this.correct = false});
  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
  Map<String, dynamic> toJson() => _$OptionToJson(this);
}

@JsonSerializable()
class Question {
  String text;
  List<Option> options;
  Question({this.options = const [], this.text = ''});
  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Quiz {
  String id;
  String title;
  String description;
  String video;
  String topic;
  List<Question> questions;

  Quiz(
      {this.title = '',
      this.video = '',
      this.description = '',
      this.id = '',
      this.topic = '',
      this.questions = const []});
  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  Map<String, dynamic> toJson() => _$QuizToJson(this);
}

@JsonSerializable()
class Topic {
  late final String id;
  final String title;
  final String description;
  final String img;
  final List<Quiz> quizzes;

  Topic(
      {this.id = '',
      this.title = '',
      this.description = '',
      this.img = 'default.png',
      this.quizzes = const []});

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}

@JsonSerializable()
class Report {
  String uid;
  int total;
  Map topics;

  Report({this.uid = '', this.topics = const {}, this.total = 0});
  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);
}

@JsonSerializable()
class Note {
  String id;
  String title;
  String content;
  String uid;
  final DateTime createdAt;

  Note({
    this.id = '',
    this.title = '',
    this.content = '',
    this.uid = '',
    required this.createdAt,
  });
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      uid: json['uid'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'uid': uid,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}

@JsonSerializable()
class LessonTopic {
  late final String id;
  final String title;
  final String description;
  final String img;

  LessonTopic({
    this.id = '',
    this.title = '',
    this.description = '',
    this.img = 'default.png',
  });

  factory LessonTopic.fromJson(Map<String, dynamic> json) =>
      _$LessonTopicFromJson(json);
  Map<String, dynamic> toJson() => _$LessonTopicToJson(this);
}

class Lesson {
  final String title;
  final String videoAssetPath;
  final String content;

  Lesson({
    required this.title,
    required this.videoAssetPath,
    required this.content,
  });
}
