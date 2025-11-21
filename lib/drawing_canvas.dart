import 'package:benkyou/painters/dotted_cross_painter.dart';
import 'package:benkyou/painters/painter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress/step_progress.dart';

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

  StepProgressController controller = StepProgressController(
    totalSteps: 5,
    initialStep: 3,
  );

  @override
  Widget build(BuildContext context) {
    final canvasSize = Size(
      MediaQuery.of(context).size.height * 0.85,
      MediaQuery.of(context).size.height * 0.40,
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StepProgress(
              totalSteps: 5,
              controller: controller,
              visibilityOptions: StepProgressVisibilityOptions.lineOnly,
              theme: const StepProgressThemeData(
                stepLineStyle: StepLineStyle(
                  lineThickness: 10,
                  borderRadius: Radius.circular(6),
                ),
                activeForegroundColor: Colors.green,
                defaultForegroundColor: Colors.grey,
              ),
            ),
            Icon(Icons.star, size: 21, color: Colors.amberAccent),
          ],
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        FilledButton.icon(
          onPressed: () {},
          label: Text("Voltar"),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blueGrey),
          ),
          icon: Icon(Icons.arrow_back),
        ),
        SizedBox(width: 150),
        FilledButton.icon(
          onPressed: () {},
          label: Text("Avancar"),
          icon: Icon(Icons.arrow_forward),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blueGrey),
          ),
          iconAlignment: IconAlignment.end,
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
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
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        "人",
                        style: GoogleFonts.kleeOne(
                          fontSize: 180,
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "人",
                        style: GoogleFonts.kleeOne(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                        ),
                      ),
                      Text(
                        "人",
                        style: GoogleFonts.kleeOne(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                        ),
                      ),
                      Text(
                        "人",
                        style: GoogleFonts.kleeOne(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                        ),
                      ),
                      Text(
                        "人",
                        style: GoogleFonts.kleeOne(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  defaultCard("Leitura", "Hito (ひと)", false),
                  defaultCard("Vocabulario", "人間 (にんげん)", true),
                  defaultCard("Vocabulario", "", true),
                  defaultCard("Exemplo de uso", "", true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget defaultCard(String title, String description, bool hasImage) {
  return SizedBox(
    height: hasImage ? 170 : 100,
    width: 340,
    child: Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardText(title, true),
            cardText(description, false),
            if (hasImage)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.search, size: 62)],
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

Widget cardText(String text, bool isTitle) {
  return Flexible(
    child: Text(
      text,
      style: GoogleFonts.kleeOne(
        fontSize: isTitle ? 18 : 24,
        fontWeight: FontWeight.bold,
        color: isTitle ? Colors.green.shade800 : Colors.black,
      ),
    ),
  );
}
