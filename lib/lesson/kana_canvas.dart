import 'package:benkyou/painters/painter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KanaCanvas extends StatefulWidget {
  @override
  final GlobalKey<KanaCanvasState> key;

  KanaCanvas({required this.character, required this.key}) : super(key: key);
  final String character;

  @override
  State<KanaCanvas> createState() => KanaCanvasState();
}

class KanaCanvasState extends State<KanaCanvas> {
  // Maybe instanciate this variable using a List an them put a path for each
  // "phase", right now the paths are all the same and they keep state forever
  final List<List<Offset>> paths = [];

  void clear() => setState(() {
    paths.clear();
  });

  @override
  Widget build(BuildContext context) {
    final canvasSize = Size(
      MediaQuery.of(context).size.height * 0.50,
      MediaQuery.of(context).size.height * 0.40,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: () => clear(), icon: Icon(Icons.delete)),
          ],
        ),
        GestureDetector(
          onPanStart: (details) => setState(() {
            paths.add([details.localPosition]);
          }),
          onPanUpdate: (details) => setState(() {
            paths.last.add(details.localPosition);
          }),
          child: CustomPaint(
            painter: Painter(paths),
            size: canvasSize,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.character,
                  style: GoogleFonts.kleeOne(
                    fontSize: 180,
                    fontWeight: FontWeight.bold,
                    color: Colors.black26,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < 2; i++)
                      Text(
                        widget.character,
                        style: GoogleFonts.kleeOne(
                          fontSize: 140,
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
