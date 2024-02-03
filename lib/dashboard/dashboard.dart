import 'package:busybeelearning/shared/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:busybeelearning/colors.dart' as customcolor;

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Image(
            image: AssetImage('assets/logo.png'),
            fit: BoxFit.fitHeight,
          ),
          title: const Text(
            'BusyBee Learning',
            textAlign: TextAlign.center,
          ),
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
              gradient: LinearGradient(
                colors: [
                  customcolor.AppColor.gradientFirst,
                  customcolor.AppColor.gradientSecond,
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
          )),
      bottomNavigationBar: const BottomNavBar(initialIndex: 0),
    );
  }
}
