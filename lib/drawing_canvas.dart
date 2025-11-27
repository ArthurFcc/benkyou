import 'package:benkyou/lesson/kana.dart';
import 'package:benkyou/lesson/kana_canvas.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
              activeForegroundColor: Color(0xFF68a49c),
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
            backgroundColor: WidgetStatePropertyAll(Color(0xFF68a49c)),
          ),
          icon: Icon(Icons.arrow_back),
        ),
        SizedBox(width: 150),
        FilledButton.icon(
          onPressed: () => currentKana == widget.kanas.length
              ? showDialog(
                  context: context,
                  fullscreenDialog: true,
                  animationStyle: AnimationStyle(
                    curve: Curves.ease,
                    duration: Durations.medium2,
                  ),
                  useSafeArea: true,
                  builder: (context) => Dialog.fullscreen(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Bom trabalho!!",
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "やったね!!",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 58),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEghpzmykJAW6ByDi9dMM-D73Em32ymN0tGRAA_VqFTkBYbMdaneScANBqloh75LPmr0xwQCpJ2evpHh09b8c-HQ0OqcdUHHy12ubksbrgUsS94cm7WzeV2zgDt2VPmoEInzMyA0GF3I_u5H/s400/plant_ooonibasu_girl.png",
                              scale: 1.2,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                    color: Color(0xFF68a49c),
                                  ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () => Navigator.of(
                                context,
                              ).popUntil((route) => route.isFirst),
                              child: Text("Concluir"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : setState(() {
                  if (currentKana < widget.kanas.length) currentKana += 1;
                }),
          label: Text(
            currentKana == widget.kanas.length ? "Concluir" : "Avançar",
          ),
          icon: Icon(Icons.arrow_forward),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFF68a49c)),
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
                    if (widget.kanas[currentKana - 1].vocabulary1.isNotEmpty)
                      defaultCard(
                        "Vocabulario",
                        widget.kanas[currentKana - 1].vocabulary1,
                        widget.kanas[currentKana - 1].vocabularyImage1,
                      ),
                    if (widget.kanas[currentKana - 1].vocabulary2.isNotEmpty)
                      defaultCard(
                        "Vocabulario",
                        widget.kanas[currentKana - 1].vocabulary2,
                        widget.kanas[currentKana - 1].vocabularyImage2,
                      ),
                    if (widget.kanas[currentKana - 1].usageExample.isNotEmpty)
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
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardText(title, true),
            cardText(description, false),
            if (image != null && image.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: image,
                      height: 80,
                      width: 80,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(color: Color(0xFF68a49c)),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ],
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
        color: isTitle ? Color(0xFF68a49c) : Colors.black87,
      ),
    ),
  );
}
