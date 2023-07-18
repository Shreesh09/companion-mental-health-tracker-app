import 'dart:math';

import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  double sideSize;

  Color color;
  TrianglePainter({required this.sideSize, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double ySize = sideSize * cos(30 * pi / 180);
    double xSize = sideSize;

    double point0x = xSize / 2;
    double point0y = ySize / 2;

    double point1x = -xSize / 2;
    double point1y = ySize / 2;

    double point2x = 0;
    double point2y = -ySize / 2;

    Path path = Path();
    path.moveTo(point0x, point0y);
    path.lineTo(point1x, point1y);
    path.lineTo(point2x, point2y);
    path.lineTo(point0x, point0y);
    path.close();
    canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill);

    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.sideSize != sideSize;
  }
}

Widget triangle(double sideSize, Color color, double angle) {
  return Transform.rotate(
    angle: angle * pi / 180,
    child: CustomPaint(
      painter: TrianglePainter(
        color: color,
        sideSize: sideSize,
      ),
    ),
  );
}
