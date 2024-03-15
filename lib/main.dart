import 'package:busybeelearning/routes.dart';
import 'package:busybeelearning/services/firestore.dart';
import 'package:busybeelearning/services/models.dart';
import 'package:busybeelearning/shared/shared.dart';
import 'package:busybeelearning/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DateTime? _lastResumedTimestamp;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _lastResumedTimestamp = DateTime.now();
        break;
      case AppLifecycleState.paused:
        if (_lastResumedTimestamp != null) {
          final sessionLength =
              DateTime.now().difference(_lastResumedTimestamp!).inSeconds;
          _updateDailyUsage(sessionLength);
        }
        break;
      default:
        break;
    }
  }

  Future<void> _updateDailyUsage(int sessionLength) async {
    final prefs = await SharedPreferences.getInstance();
    // Get the current stored usage and the last update date
    int currentUsage = prefs.getInt('daily_usage') ?? 0;
    String? lastUpdateDate = prefs.getString('last_update_date');

    // Convert current date to a string
    final today = DateTime.now();
    final todayString = "${today.year}-${today.month}-${today.day}";

    // Check if the last update was on a different day
    if (lastUpdateDate != todayString) {
      currentUsage = 0; // Reset the usage for a new day
    }

    // Update the daily usage and last update date
    await prefs.setInt('daily_usage', currentUsage + sessionLength);
    await prefs.setString('last_update_date', todayString);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Text('error');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider(
              create: (_) => FirestoreService().streamReport(),
              catchError: (_, err) => Report(),
              initialData: Report(),
              child: MaterialApp(
                  debugShowCheckedModeBanner: true,
                  routes: appRoutes,
                  theme: appTheme));
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const MaterialApp(home: LoadingScreen());
      },
    );
  }
}
