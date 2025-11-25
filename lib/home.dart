import 'dart:convert';

import 'package:benkyou/drawing_canvas.dart';
import 'package:benkyou/lesson/kana.dart';
import 'package:benkyou/shared/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Kana> kanas = [];

  Future loadJsonData(String type, (int from, int to) range) async {
    final json = await rootBundle.loadString('assets/kana.json');
    final data = jsonDecode(json);
    var jsonParse = data[type] as List;
    var kanaList = jsonParse.map((i) => Kana.fromJson(i)).toList();
    setState(() {
      kanas = kanaList.getRange(range.$1, range.$2).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PRATIKANA", style: GoogleFonts.notoSans(fontSize: 21)),
      ),
      body: Column(
        spacing: 18,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 18,
                ),
                child: Text(
                  "Pratique:",
                  style: GoogleFonts.notoSans(fontSize: 21),
                ),
              ),
            ],
          ),
          CustomCard(
            title: "Hiragana",
            action: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Selecione o silabario"),
                constraints: BoxConstraints(maxHeight: 350),
                content: Column(
                  children: [
                    FilledButton(
                      onPressed: () {
                        loadJsonData('hiragana', (0, 5));
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DrawingCanvas(kanas: kanas),
                          ),
                        );
                      },
                      child: Text(
                        "あ〜お",
                        style: GoogleFonts.kleeOne(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        loadJsonData('hiragana', (5, 10));
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DrawingCanvas(kanas: kanas),
                          ),
                        );
                      },
                      child: Text(
                        "か〜こ",
                        style: GoogleFonts.kleeOne(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        loadJsonData('hiragana', (10, 15));
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DrawingCanvas(kanas: kanas),
                          ),
                        );
                      },
                      child: Text(
                        "さ〜そ",
                        style: GoogleFonts.kleeOne(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomCard(
            title: "Katakana",
            action: () => loadJsonData('hiragana', (0, 0)),
          ),
          CustomCard(
            title: "Kanji",
            action: () => loadJsonData('hiragana', (0, 0)),
          ),
        ],
      ),
    );
  }
}
