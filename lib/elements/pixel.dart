import 'package:flutter/material.dart';

class BoardPixel extends StatelessWidget {
  var color;
  var child;

  BoardPixel({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.all(1),
      child: Center(
        child: Text(
          child.toString(),
        ),
      ),
    );
  }
}
