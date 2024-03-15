import 'package:flutter/material.dart';
import 'package:busybeelearning/colors.dart' as customcolor;

class NeuBox extends StatelessWidget {
  final child;
  const NeuBox({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: customcolor.AppColor.primaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          // dark shadow bottom right
          BoxShadow(
            color: Color.fromARGB(255, 150, 115, 0),
            offset: Offset(5, 5),
            blurRadius: 5,
          ),
          // light shadow top left
          BoxShadow(
            color: Color.fromARGB(255, 255, 226, 131),
            offset: Offset(-5, -5),
            blurRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
