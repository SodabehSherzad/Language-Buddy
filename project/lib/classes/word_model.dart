class WordModel {
  final String word;
  final String word_en;
  final String word_fa;
  bool isFavorite;
  bool isExpanded;

  WordModel({
    required this.word,
    required this.word_en,
    required this.word_fa,
    this.isFavorite = false,
    this.isExpanded = false,
  });
}
