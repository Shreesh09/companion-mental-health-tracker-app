import 'package:flutter/material.dart';

class TimerTextField extends StatelessWidget {
  final double height;
  final double width;
  final TextEditingController? controller;
  const TimerTextField({
    super.key,
    this.height = 30,
    this.width = 100,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
          maxLength: 2,
          cursorColor: Colors.orange,
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              hintText: "00",
              hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: height,
                  fontWeight: FontWeight.bold)),
          style: TextStyle(
              fontSize: height,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
    );
  }
}
