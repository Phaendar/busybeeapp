import 'package:busybeelearning/dashboard/dashboard.dart';
import 'package:busybeelearning/home/home.dart';
import 'package:busybeelearning/lessons/lessonsoverview.dart';
import 'package:busybeelearning/login/login.dart';
import 'package:busybeelearning/music/musicplayer.dart';
import 'package:busybeelearning/notes/new_note.dart';
import 'package:busybeelearning/notes/notes.dart';
import 'package:busybeelearning/profile/profile.dart';
import 'package:busybeelearning/quizoverview/quizoverview.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/notes': (context) => const NotesScreen(),
  '/dashboard': (context) => const DashboardScreen(),
  '/quizoverview': (context) => const QuizOverviewScreen(),
  '/new-note': (context) => const NewNoteScreen(),
  '/lessonsoverview': (context) => const LessonsOverviewScreen(),
  '/musicplayer': (context) => const MusicPlayerScreen(selectedIndex: 0),
};
