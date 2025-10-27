import 'package:benkyou/painters/dotted_cross_painter.dart';
import 'package:benkyou/painters/painter.dart';
import 'package:flutter/material.dart';

class DrawingCanvas extends StatefulWidget {
  const DrawingCanvas({super.key});

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  List<List<Offset>> paths = [];

  void _undo() {
    if (paths.isNotEmpty) {
      setState(() {
        paths.removeLast();
      });
    }
  }

  void _clear() {
    if (paths.isNotEmpty) {
      setState(() {
        paths.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final canvasSize = Size(
      MediaQuery.of(context).size.height * 0.85,
      MediaQuery.of(context).size.height * 0.40,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("勉強 | Benkyou"),
        actions: [
          IconButton(
            onPressed: () => _undo(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          IconButton(onPressed: () => _clear(), icon: const Icon(Icons.delete)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  Text("あ", style: TextStyle(fontSize: 82)),
                  Text("あお", style: TextStyle(fontSize: 32)),
                  CircleAvatar(radius: 16, backgroundColor: Colors.blue),
                ],
              ),
            ),

            GestureDetector(
              onPanStart: (details) => setState(() {
                paths.add([details.localPosition]);
              }),
              onPanUpdate: (details) => setState(() {
                paths.last.add(details.localPosition);
              }),
              child: Container(
                width: canvasSize.width,
                height: canvasSize.height,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white30,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black26, width: 2),
                  backgroundBlendMode: BlendMode.clear,
                ),
                child: CustomPaint(
                  painter: Painter(paths),
                  size: canvasSize,
                  child: Stack(
                    alignment: AlignmentGeometry.center,
                    children: [
                      CustomPaint(
                        painter: DottedCrossPainter(),
                        size: Size.infinite,
                      ),
                      Text(
                        "あ",
                        style: TextStyle(fontSize: 180, color: Colors.black26),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
