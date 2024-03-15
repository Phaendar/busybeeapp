import 'package:busybeelearning/shared/bottom_nav.dart';
import 'package:busybeelearning/shared/neu_box.dart';
import 'package:flutter/material.dart';
import 'package:busybeelearning/colors.dart' as customcolor;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $urlString';
  }
}

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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_02.jpg'),
            fit: BoxFit.cover,
            opacity: 1,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(228, 217, 189, 1),
                      Color.fromRGBO(228, 217, 189, 0.2),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: CalendarCarousel(
                  onDayPressed: (DateTime date, List events) {
                    // This function is triggered when a date is pressed.
                  },
                  weekendTextStyle: const TextStyle(
                    color: Colors.red,
                  ),
                  thisMonthDayBorderColor: Colors.grey,
                  weekFormat: false,
                  height: 420.0,
                  selectedDateTime: DateTime.now(),
                  daysHaveCircularBorder: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //What next? section
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(228, 217, 189, 1),
                      Color.fromRGBO(228, 217, 189, 0.2),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.all(40),
                child: NeuBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        textAlign: TextAlign.center,
                        'What next?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        textAlign: TextAlign.center,
                        'Here are some suggestions to keep you learning:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                      ListBody(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.book),
                            title: const Text(
                              'BBC Bitesize',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () => _launchURL(
                                'https://www.bbc.co.uk/bitesize/primary'),
                          ),
                          ListTile(
                            leading: const Icon(Icons.public),
                            title: const Text('National Geographic',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () => _launchURL(
                                'https://kids.nationalgeographic.com/'),
                          ),
                          ListTile(
                            leading: const Icon(Icons.school),
                            title: const Text('DK Learning',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () =>
                                _launchURL('https://learning.dk.com/uk'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(initialIndex: 0),
    );
  }
}
