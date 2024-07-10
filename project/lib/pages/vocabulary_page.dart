import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../data/apartment.dart';
import '../data/bank.dart';
import '../data/bathroom_appliances.dart';
import '../data/bedroom_appiances.dart';
import '../data/dentist_visit.dart';
import '../data/doctor_specialists.dart';
import '../data/doctor_visit.dart';
import '../data/emergency.dart';
import '../data/immigration.dart';
import '../data/kitchen_appliances.dart';
import '../data/pharmacy.dart';
import '../data/psychology.dart';
import '../data/shopping.dart';
import '../data/transportation.dart';
import '../data/travel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/vocabulary_model.dart';
import '../classes/word_model.dart';
import '../methods/get_data.dart'; // Ensure this import is correct
import '../data/airport.dart';
import '../data/animals.dart';
import '../data/computer_and_it.dart';
import '../data/cosmetics.dart';
import '../data/culture.dart';
import '../data/dating.dart';
import '../data/diseases.dart';
import '../data/education.dart';
import '../data/environment.dart';
import '../data/family.dart';
import '../data/feelings.dart';
import '../data/food.dart';
import '../data/fruits.dart';
import '../data/hobbies.dart';
import '../data/hotel.dart';
import '../data/human_body.dart';
import '../data/insurance.dart';
import '../data/job_interview.dart';
import '../data/legal_matters.dart';
import '../data/living_room_appliances.dart';
import '../data/public_services.dart';
import '../data/social_interaction.dart';
import '../data/spices.dart';
import '../data/stationary.dart';
import '../data/useful_adjectives.dart';
import '../data/useful_nouns.dart';
import '../data/useful_verbs.dart';
import '../data/useful_words.dart';
import '../data/utilities.dart';
import '../data/vegetables.dart';
import '../data/weather.dart';

class GermanWordProvider extends ChangeNotifier {
  bool showGermanWords = false;

  void toggleShowGermanWords() {
    showGermanWords = !showGermanWords;
    notifyListeners();
  }
}

class WordItem extends StatefulWidget {
  final WordModel wordModel;
  final Function(bool) onFavoriteChanged;
  final Function(bool) onExpansionChanged;
  final String word;
  final String word_en;
  final String word_fa;
  final FlutterTts tts;
  bool isFavorite;
  bool isExpanded;
  final String language;
  bool isExpansionEnabled;
  bool isTtsEnabled;
  WordItem({
    required this.language,
    required this.word,
    required this.word_en,
    required this.word_fa,
    required this.wordModel,
    required this.tts,
    this.isFavorite = false,
    required this.onFavoriteChanged,
    this.isExpanded = false,
    required this.onExpansionChanged,
    required this.isExpansionEnabled,
    required this.isTtsEnabled,
  });

  @override
  _WordItemState createState() => _WordItemState();
}

class _WordItemState extends State<WordItem> {
  @override
  Widget build(BuildContext context) {
    final displayWord =
    widget.language == "en" ? widget.word_en : widget.word_fa;

    return Card(
      elevation: 1,
      child: Column(
        children: [
          ExpansionPanelList(
            elevation: 1,
            expandedHeaderPadding: const EdgeInsets.all(0),
            expansionCallback: (int itemIndex, bool isExpanded) {
              widget.onExpansionChanged(isExpanded);
              if (widget.isTtsEnabled) widget.tts.speak(widget.word);
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      widget.word,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      displayWord,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ),
                isExpanded: widget.isExpanded,
              ),
            ],
          ),
          // New Row for player icon and favorite icon
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  widget.tts.speak(widget.word);
                },
                icon: const Icon(Icons.volume_up),
              ),
              IconButton(
                onPressed: () {
                  widget.onFavoriteChanged(!widget.isFavorite);
                },
                icon: widget.isFavorite
                    ? const Icon(
                  Icons.star,
                  color: Colors.blue,
                )
                    : const Icon(
                  Icons.star,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VocabularyPage extends StatefulWidget {
  static const RoutName = "/word";

  final String language;
  final bool isRandom;
  final bool isExpansionEnabled;
  final bool isTtsEnabled;
  final dynamic selectedTopic; // Ensure this is properly typed or dynamic

  VocabularyPage({
    required this.isRandom,
    required this.isExpansionEnabled,
    required this.isTtsEnabled,
    required this.language,
    required this.selectedTopic,
  }) : assert(selectedTopic != null, 'selectedTopic cannot be null'),
        assert(selectedTopic.id != null, 'selectedTopic.id cannot be null');

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  final FlutterTts flutterTts = FlutterTts();
  bool expandAll = false; // Track overall expansion state
  List<String> favoriteWords = [];
  int currentlyExpandedIndex = -1; // Index of the currently expanded panel
  bool isFirstLoad = true;

  // Function to toggle expand/collapse all panels
  void _toggleExpandAll(bool value) {
    setState(() {
      expandAll = value;
      currentlyExpandedIndex = expandAll ? -1 : currentlyExpandedIndex;
    });
  }

  void _updateWordFavorite(
      String word,
      String word_fa,
      bool isFavorite,
      ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentFavorites = prefs.getStringList('favoriteWords') ?? [];

    final wordData = '$word|$word_fa';
    print(wordData);

    if (isFavorite) {
      currentFavorites.add(wordData);
    } else {
      currentFavorites.remove(wordData);
    }

    await prefs.setStringList('favoriteWords', currentFavorites);
  }

  // Function to handle expansion changes
  void _handleExpansion(int index, bool isExpanded) {
    if (!expandAll) {
      // Toggle the expansion state of the clicked panel when the switch is off
      setState(() {
        currentlyExpandedIndex = isExpanded ? -1 : index;
      });
    } else {
      // When the switch is on, collapse the clicked panel when it's expanded
      setState(() {
        currentlyExpandedIndex = isExpanded ? -1 : index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initTts();
    _loadFavoriteWords();
    _shuffleData(); // Shuffle the data when initializing the page
    setState(() {
      expandAll = widget.isExpansionEnabled;
    });
  }

  /*
  void _shuffleData() {
    if (widget.selectedTopic != null && widget.selectedTopic.id != null) {
      final topic = mapIdToTopic(widget.selectedTopic.id);
      final _data = VocabularyMethods(topic!);
      jsonData = _data.getVocabularyData();
      if (widget.isRandom) {
        jsonData.shuffle();
      }
    } else {
      // Handle the case where selectedTopic or its id is null
      print('selectedTopic or selectedTopic.id is null');
      jsonData = []; // Or provide a default value
    }
  }
   */

  void _shuffleData() {
    if (widget.selectedTopic != null && widget.selectedTopic!.id != null) {
      final topic = mapIdToTopic(widget.selectedTopic!.id);
      if (topic != null) {
        final _data = VocabularyMethods(topic.cast<Map<String, dynamic>>());
        jsonData = _data.getVocabularyData();
        if (widget.isRandom) {
          jsonData.shuffle();
        }
      } else {
        // Handle case where topic is null or empty
        jsonData = [];
      }
    } else {
      // Handle the case where selectedTopic or its id is null
      print('selectedTopic or selectedTopic.id is null');
      jsonData = []; // Or provide a default value
    }
  }



  Future<void> _loadFavoriteWords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteWords = prefs.getStringList('favoriteWords') ?? [];
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _initTts() async {
    await flutterTts.setLanguage('de-DE');
    await flutterTts.setPitch(1.0);
  }

  List<VocabularyModel> jsonData = [];

  Map<int, List> topicData = {
    1: doctor_visit,
    2: dentist_visit,
    3: pharmacy,
    4: diseases,
    5: doctor_specialists,
    6: psychology,
    7: emergency,
    8: insurance,
    9: bank,
    10: immigration,
    11: transportation,
    12: travel,
    13: shopping,
    14: apartment,
    15: kitchen_appliances,
    16: bathroom_appliances,
    17: bedroom_appliances,
    18: living_room_appliances,
    19: computer_and_it,
    20: stationary,
    21: education,
    22: job_interview,
    23: social_interaction,
    24: culture,
    25: legal_matters,
    26: utilities,
    27: public_services,
    28: weather,
    29: hobbies,
    30: environment,
    31: dating,
    32: cosmetics,
    33: food,
    34: animals,
    35: vegetables,
    36: fruits,
    37: spices,
    38: feelings,
    39: human_body,
    40: family,
    41: airport,
    42: hotel,
    43: useful_words,
    44: useful_verbs,
    45: useful_adjectives,
    46: useful_nouns,
  };

  List? mapIdToTopic(int? id) {
    if (id != null && topicData.containsKey(id)) {
      return topicData[id];
    } else {
      throw Exception("Invalid or null topic ID");
    }
  }

  @override
  Widget build(BuildContext context) {
    String language = widget.language;
    List<WordModel> words = [];

    words = jsonData
        .map((vocabularyItem) => WordModel(
      word: vocabularyItem.name_de,
      word_en: vocabularyItem.name_en,
      word_fa: vocabularyItem.name_fa,
    ))
        .toList();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Expand or Collapse all words: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Switch(
                  value: expandAll,
                  onChanged: _toggleExpandAll,
                  activeColor:
                  Colors.blue, // Change this color to your desired color
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 5),
              itemCount: jsonData.length,
              itemBuilder: (context, index) {
                final wordModel = words[index];
                final wordData = '${wordModel.word}|${wordModel.word_fa}';
                return WordItem(
                  language: language,
                  word: wordModel.word,
                  word_en: wordModel.word_en,
                  word_fa: wordModel.word_fa,
                  wordModel: wordModel,
                  tts: flutterTts,
                  isFavorite: favoriteWords.contains(wordData),
                  isExpanded: expandAll || currentlyExpandedIndex == index,
                  onExpansionChanged: (isExpanded) {
                    _handleExpansion(index, isExpanded);
                  },
                  onFavoriteChanged: (isFavorite) {
                    _updateWordFavorite(
                      wordModel.word,
                      wordModel.word_fa,
                      isFavorite,
                    );
                    _loadFavoriteWords();
                  },
                  isTtsEnabled: widget.isTtsEnabled,
                  isExpansionEnabled: widget.isExpansionEnabled,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
