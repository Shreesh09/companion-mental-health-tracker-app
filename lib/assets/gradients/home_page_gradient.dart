import 'package:flutter/material.dart';

const LinearGradient homePageGradient = LinearGradient(
  // Where the linear gradient begins and ends
  begin: Alignment.topLeft,
  end: Alignment.bottomCenter,
  // Add one stop for each color.
  // Stops should increase from 0 to 1
  stops: [0.0, 0.55],
  colors: [
    // Colors are easy thanks to Flutter's Colors class.
    Color(0xFF4D4F78),
    Color(0xFF040725),
  ],
);

//Color.fromARGB(197, 106, 72, 103),
    // Color.fromARGB(195, 24, 28, 80),