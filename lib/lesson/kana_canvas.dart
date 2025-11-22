import 'package:benkyou/painters/painter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KanaCanvas extends StatefulWidget {
  const KanaCanvas({
    required this.character,
    this.isSingleCharacter = true,
    super.key,
  });
  final String character;
  final bool isSingleCharacter;

  @override
  State<KanaCanvas> createState() => _KanaCanvasState();
}

class _KanaCanvasState extends State<KanaCanvas> {
  final List<List<Offset>> paths = [];

  @override
  Widget build(BuildContext context) {
    final canvasSize = Size(
      MediaQuery.of(context).size.height * 0.85,
      MediaQuery.of(context).size.height * 0.40,
    );

    return GestureDetector(
      onPanStart: (details) => setState(() {
        paths.add([details.localPosition]);
      }),
      onPanUpdate: (details) => setState(() {
        paths.last.add(details.localPosition);
      }),
      child: SizedBox(
        child: CustomPaint(
          painter: Painter(paths),
          size: canvasSize,
          child: Row(
            spacing: 18,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isSingleCharacter) ...{
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      widget.character,
                      style: GoogleFonts.kleeOne(
                        fontSize: 180,
                        fontWeight: FontWeight.bold,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                ),
              } else ...{
                for (var i = 0; i < 2; i++)
                  Text(
                    widget.character,
                    style: GoogleFonts.kleeOne(
                      fontSize: 140,
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                    ),
                  ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
