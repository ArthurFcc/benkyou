import 'package:flutter/material.dart';

class DottedCrossPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    const double dotSize = 12;
    const double dotSpacing = 12;

    for (double i = 0; i < size.width; i += dotSize + dotSpacing) {
      canvas.drawLine(
        Offset(i, size.height / 2),
        Offset(i + dotSize, size.height / 2),
        paint,
      );
    }

    for (double i = 0; i < size.height; i += dotSize + dotSpacing) {
      canvas.drawLine(
        Offset(size.width / 2, i),
        Offset(size.width / 2, i + dotSize),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
