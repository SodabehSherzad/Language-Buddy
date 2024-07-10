import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/vocabulary_model.dart';
import '../classes/word_model.dart';
import 'vocabulary_page.dart';


class SearchResultsPage extends StatefulWidget {
  final List<VocabularyModel> searchResults;
  final String language;

  SearchResultsPage({required this.searchResults, required this.language});
  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  final FlutterTts flutterTts = FlutterTts();
  Future<void> _initTts() async {
    await flutterTts.setLanguage('de-DE');
    await flutterTts.setPitch(1.0);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  List<String> favoriteWords = [];
  List<bool> isExpandedList = []; // List to track expansion state

  @override
  Widget build(BuildContext context) {
    List<VocabularyModel> searchResults = widget.searchResults;
    List<WordModel> words = [];

    words = searchResults
        .map((vocabularyItem) => WordModel(
      word: vocabularyItem.name_de,
      word_en: vocabularyItem.name_en,
      word_fa: vocabularyItem.name_fa,
    ))
        .toList();

    // Initialize isExpandedList based on the number of search results
    if (isExpandedList.isEmpty) {
      isExpandedList = List.generate(searchResults.length, (index) => true);
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final vocabularyItem = searchResults[index];
          final wordModel = words[index];
          final wordData = '${wordModel.word}|${wordModel.word_fa}';
          return WordItem(
            language: widget.language, // or any default language you want to use
            word: vocabularyItem.name_de,
            word_en: vocabularyItem.name_en,
            word_fa: vocabularyItem.name_fa,
            wordModel: WordModel(
              word: vocabularyItem.name_de,
              word_en: vocabularyItem.name_en,
              word_fa: vocabularyItem.name_fa,
            ),
            tts: flutterTts,
            isFavorite: favoriteWords.contains(wordData),
            isExpanded: isExpandedList[index], // Pass the expansion state
            onExpansionChanged: (isExpanded) {
              setState(() {
                isExpandedList[index] = isExpanded; // Update the expansion state
              });
            },
            onFavoriteChanged: (isFavorite) {
              _updateWordFavorite(
                wordModel.word,
                wordModel.word_fa,
                isFavorite,
              );
              _loadFavoriteWords();
            }, isExpansionEnabled: wordModel.isExpanded, isTtsEnabled: false,
          );
        },
      ),
    );
  }

  Future<void> _loadFavoriteWords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteWords = prefs.getStringList('favoriteWords') ?? [];
    });
  }

  void _updateWordFavorite(String word, String word_fa, bool isFavorite) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentFavorites = prefs.getStringList('favoriteWords') ?? [];

    final wordData = '$word|$word_fa';

    if (isFavorite) {
      currentFavorites.add(wordData);
    } else {
      currentFavorites.remove(wordData);
    }

    await prefs.setStringList('favoriteWords', currentFavorites);
  }
}
