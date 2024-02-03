import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:busybeelearning/services/services.dart';
import 'package:busybeelearning/shared/shared.dart';
import 'package:busybeelearning/colors.dart' as customcolor;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(user.displayName ?? 'Guest'),
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
              boxShadow: [
                // dark shadow bottom right
                BoxShadow(
                  color: Colors.yellow.shade700,
                  offset: const Offset(0, 5),
                  blurRadius: 10.0,
                ),
              ],
              gradient: customcolor.AppColor.customGradient,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(user.photoURL ??
                        'https://www.gravatar.com/avatar/placeholder'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(user.email ?? '',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              const Spacer(),
              Text('${report.total}',
                  style: Theme.of(context).textTheme.displayMedium),
              Text('Quizzes Completed',
                  style: Theme.of(context).textTheme.titleSmall),
              const Spacer(),
              ElevatedButton(
                child:
                    const Text('Logout', style: TextStyle(color: Colors.black)),
                onPressed: () async {
                  await AuthService().signOut();
                  if (mounted) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBar(initialIndex: 4),
      );
    } else {
      return const Loader();
    }
  }
}
