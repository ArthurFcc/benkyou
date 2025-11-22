class Kana {
  final String character;
  final String reading;
  final String vocabulary1;
  final String vocabularyImage1;
  final String vocabulary2;
  final String vocabularyImage2;
  final String usageExample;
  final String usageExampleImage;

  Kana({
    required this.character,
    required this.reading,
    required this.vocabulary1,
    required this.vocabularyImage1,
    required this.vocabulary2,
    required this.vocabularyImage2,
    required this.usageExample,
    required this.usageExampleImage,
  });

  factory Kana.fromJson(Map<String, dynamic> json) {
    return Kana(
      character: json['character'] as String,
      reading: json['reading'] as String,
      vocabulary1: json['vocabulary1'] as String,
      vocabularyImage1: json['vocabularyImage1'] as String,
      vocabulary2: json['vocabulary2'] as String,
      vocabularyImage2: json['vocabularyImage2'] as String,
      usageExample: json['usageExample'] as String,
      usageExampleImage: json['usageExampleImage'] as String,
    );
  }
}
