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
  void _onSelectMenuItem(String value) {
    switch (value) {
      case 'Settings':
        Navigator.pushNamed(context, '/usersettings');
        // Navigate to settings screen or perform any action
        break;
      case 'Help':
        // Navigate to help screen or perform any action
        break;
      case 'Contact Us':
        // Navigate to contact us screen or perform any action
        break;
    }
  }

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
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg_02.jpg'),
              fit: BoxFit.cover,
              opacity: 1,
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text('Profile',
                      style: Theme.of(context).textTheme.headlineLarge),
                ),
                Container(
                  width: 90,
                  height: 90,
                  margin: const EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(user.photoURL ?? ''),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(user.email ?? '',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Text('${report.score}',
                          style: Theme.of(context).textTheme.displayMedium),
                      Text('Score',
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(16) +
                      const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: const Text('Logout',
                            style: TextStyle(color: Colors.black)),
                        onPressed: () async {
                          await AuthService().signOut();
                          if (mounted) {
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('/', (route) => false);
                          }
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: customcolor.AppColor.customGradient,
                          boxShadow: [
                            // dark shadow bottom right
                            BoxShadow(
                              color: Colors.grey.shade500,
                              offset: const Offset(5, 5),
                              blurRadius: 5.0,
                            ),
                            // light shadow top left
                            const BoxShadow(
                              color: Colors.white,
                              offset: Offset(-5, -5),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: PopupMenuButton<String>(
                          color: Colors.yellow.shade700,
                          icon: const Icon(Icons.settings, size: 40),
                          onSelected: _onSelectMenuItem,
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'Settings',
                              child: Text('Settings'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Help',
                              child: Text('Help'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Contact Us',
                              child: Text('Contact Us'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(initialIndex: 4),
      );
    } else {
      return const Loader();
    }
  }
}
