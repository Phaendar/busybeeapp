import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final child;
  const NeuBox({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // dark shadow bottom right
          BoxShadow(
            color: Colors.yellow.shade700,
            offset: const Offset(5, 5),
            blurRadius: 5,
          ),
          // light shadow top left
          BoxShadow(
            color: Colors.yellow.shade200,
            offset: const Offset(-5, -5),
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
