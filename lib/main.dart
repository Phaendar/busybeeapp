import 'package:busybeelearning/routes.dart';
import 'package:busybeelearning/services/firestore.dart';
import 'package:busybeelearning/services/models.dart';
import 'package:busybeelearning/shared/shared.dart';
import 'package:busybeelearning/theme.dart';
import 'package:flutter/material.dart';

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

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
