import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class BasicBox extends StatelessWidget {
  final Widget content;
  final double? width;
  final double? height;

  const BasicBox({super.key, required this.content, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: widgetColor,
            boxShadow: [
              BoxShadow(offset: Offset(2, 2), blurRadius: 6, spreadRadius: 1)
            ]),
        child: Center(child: content),
      ),
    );
  }
}
