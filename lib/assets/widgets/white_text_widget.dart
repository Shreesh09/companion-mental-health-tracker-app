import 'package:flutter/material.dart';

class WhiteText extends StatelessWidget {
  final double? fontSize;
  final String data;
  final FontWeight? fontWeight;
  const WhiteText(this.data, {super.key, this.fontSize, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          color: Colors.white, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
