import 'package:benkyou/lesson/kana.dart';
import 'package:benkyou/lesson/kana_canvas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress/step_progress.dart';

class DrawingCanvas extends StatefulWidget {
  const DrawingCanvas({super.key, required this.kanas});

  final List<Kana> kanas;

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  int currentKana = 1;

  @override
  Widget build(BuildContext context) {
    StepProgressController controller = StepProgressController(
      totalSteps: widget.kanas.length,
      initialStep: currentKana - 1,
    );

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 32),
          child: StepProgress(
            totalSteps: widget.kanas.length,
            controller: controller,
            visibilityOptions: StepProgressVisibilityOptions.lineOnly,
            theme: const StepProgressThemeData(
              stepLineStyle: StepLineStyle(
                lineThickness: 8,
                isBreadcrumb: true,
              ),
              activeForegroundColor: Colors.green,
              defaultForegroundColor: Colors.grey,
            ),
          ),
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        FilledButton.icon(
          onPressed: () => setState(() {
            if (currentKana > 1) currentKana -= 1;
          }),
          label: Text("Voltar"),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blueGrey),
          ),
          icon: Icon(Icons.arrow_back),
        ),
        SizedBox(width: 150),
        FilledButton.icon(
          onPressed: () => setState(() {
            if (currentKana < widget.kanas.length) currentKana += 1;
          }),
          label: Text("Avancar"),
          icon: Icon(Icons.arrow_forward),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blueGrey),
          ),
          iconAlignment: IconAlignment.end,
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            KanaCanvas(character: widget.kanas[currentKana - 1].character),
            KanaCanvas(
              character: widget.kanas[currentKana - 1].character,
              isSingleCharacter: false,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    defaultCard(
                      "Leitura",
                      widget.kanas[currentKana - 1].reading,
                      null,
                    ),
                    defaultCard(
                      "Vocabulario",
                      widget.kanas[currentKana - 1].vocabulary1,
                      widget.kanas[currentKana - 1].vocabularyImage1,
                    ),
                    defaultCard(
                      "Vocabulario",
                      widget.kanas[currentKana - 1].vocabulary2,
                      widget.kanas[currentKana - 1].vocabularyImage2,
                    ),
                    defaultCard(
                      "Exemplo de uso",
                      widget.kanas[currentKana - 1].usageExample,
                      widget.kanas[currentKana - 1].usageExampleImage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget defaultCard(String title, String description, String? image) {
  return SizedBox(
    height: image != null ? 190 : 100,
    width: 380,
    child: Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardText(title, true),
            cardText(description, false),
            if (image != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Image.network(image, height: 80)],
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
      softWrap: true,
      style: GoogleFonts.kleeOne(
        fontSize: isTitle ? 18 : 24,
        fontWeight: FontWeight.bold,
        color: isTitle ? Colors.green.shade800 : Colors.black,
      ),
    ),
  );
}
