import 'package:flutter/material.dart';
import 'package:busybeelearning/services/models.dart';

class QuizState with ChangeNotifier {
  double _progress = 0;
  Option? _selected;
  int _score = 0; // Add a property to track the score

  final PageController controller = PageController();

  double get progress => _progress;
  Option? get selected => _selected;
  int get score => _score; // Getter for the score

  set progress(double newValue) {
    _progress = newValue;
    notifyListeners();
  }

  set selected(Option? newValue) {
    _selected = newValue;
    notifyListeners();
  }

  // Method to increment the score
  void incrementScore(int points) {
    _score += points;
    notifyListeners();
  }

// Method to mark the quiz as complete
  Future<void> completeQuiz(Quiz quiz) async {
    // This can be adjusted based on quiz difficulty, correctness of answers, etc.
    int pointsAwardedForCompletion = 10;

    // Update the local score
    incrementScore(pointsAwardedForCompletion);

    // Notify listeners of the updated score
    notifyListeners();
  }

  void nextPage() async {
    await controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}
