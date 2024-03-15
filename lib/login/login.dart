import 'package:busybeelearning/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:busybeelearning/colors.dart' as customcolor;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/logo.png'),
            const Text(
              'Busy Bee Learning',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    // dark shadow bottom right
                    BoxShadow(
                      color: Color.fromARGB(255, 150, 115, 0),
                      offset: Offset(5, 5),
                      blurRadius: 3,
                    ),
                    // light shadow top left
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 226, 131),
                      offset: Offset(-5, -5),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: LoginButton(
                  icon: FontAwesomeIcons.userNinja,
                  text: 'Continue as Guest',
                  loginMethod: AuthService().anonLogin,
                  color: customcolor.AppColor.primaryColor,
                ),
              ),
            ),
            LoginButton(
              text: 'Sign in with Google',
              icon: FontAwesomeIcons.google,
              color: Colors.blue,
              loginMethod: AuthService().googleLogin,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    required this.loginMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.black,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
        onPressed: () => loginMethod(),
        label: Text(text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
