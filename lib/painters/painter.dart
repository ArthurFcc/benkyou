import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  final List<List<Offset>> paths;

  const Painter(this.paths);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < paths.length; i++) {
      final paint = Paint()
        ..color = Colors.black
        ..strokeWidth = 8
        ..strokeCap = StrokeCap.round;

      for (int j = 0; j < paths[i].length - 1; j++) {
        canvas.drawLine(paths[i][j], paths[i][j + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
