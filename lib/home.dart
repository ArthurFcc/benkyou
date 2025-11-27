import 'dart:convert';

import 'package:benkyou/drawing_canvas.dart';
import 'package:benkyou/lesson/kana.dart';
import 'package:benkyou/shared/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Kana>> loadJsonData(String type, (int from, int to) range) async {
    final json = await rootBundle.loadString('assets/kana.json');
    final data = jsonDecode(json);
    var jsonParse = data[type] as List;
    var kanaList = jsonParse.map((i) => Kana.fromJson(i)).toList();
    return kanaList.getRange(range.$1, range.$2).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PRATIKANA", style: TextStyle(fontSize: 21))),
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
                child: Text("Pratique:", style: TextStyle(fontSize: 21)),
              ),
            ],
          ),
          CustomCard(
            title: "Hiragana",
            action: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Selecione o silabário"),
                constraints: BoxConstraints(maxHeight: 600),
                content: Column(
                  children: [
                    kanaLoad("あ〜お", (0, 5)),
                    kanaLoad("か〜こ", (5, 10)),
                    kanaLoad("さ〜そ", (10, 15)),
                    kanaLoad("た〜と", (15, 20)),
                    kanaLoad("な〜の", (20, 25)),
                    kanaLoad("は〜ほ", (25, 30)),
                    kanaLoad("ま〜も", (30, 35)),
                    kanaLoad("や～よ", (35, 38)),
                    kanaLoad("ら～ろ", (38, 43)),
                    kanaLoad("わ～ん", (44, 46)),
                  ],
                ),
              ),
            ),
          ),
          CustomCard(
            title: "Hiragana (Dakuten & Handakuten)",
            action: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Selecione o silabário"),
                constraints: BoxConstraints(maxHeight: 350),
                content: Column(
                  children: [
                    kanaLoad("が〜ご", (46, 51)),
                    kanaLoad("ざ〜ぞ", (51, 56)),
                    kanaLoad("だ〜ど", (56, 61)),
                    kanaLoad("ば〜ぼ", (61, 66)),
                    kanaLoad("ぱ〜ぽ", (66, 71)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget kanaLoad(String text, (int, int) range) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () async {
          var kanas = await loadJsonData('hiragana', range);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DrawingCanvas(kanas: kanas),
            ),
          );
        },
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Color(0xFF68a49c)),
        ),
        child: Text(text, style: TextStyle(fontSize: 21)),
      ),
    );
  }
}
