import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../classes/conversation_model.dart';
import '../data/airport_conversation.dart';
import '../data/apartment_conversation.dart';
import '../data/bank_conversation.dart';
import '../data/dentist_visit_conversation.dart';
import '../data/doctor_visit_conversation.dart';
import '../data/food_conversation.dart';
import '../data/general_conversation.dart';
import '../data/hotel_conversation.dart';
import '../data/immigration_conversation.dart';
import '../data/job_interview_conversation.dart';
import '../data/pharmacy_conversation.dart';
import 'package:provider/provider.dart';

import '../classes/theme_notifire.dart';
import '../data/shopping_conversation.dart';
import '../methods/get_data.dart';

class WordListItem extends StatelessWidget {
  final String senderDE, messageDE, sender, message, language;
  final FlutterTts tts;

  WordListItem({
    required this.senderDE,
    required this.messageDE,
    required this.sender,
    required this.message,
    required this.language,
    required this.tts,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkModeEnabled = Provider.of<ThemeNotifier>(context).isDarkModeEnabled;
    final isPersian = language == "fa";
    final isGermanRTL = language == "de";
    final isSenderMessage = sender == senderDE;
    final cardColor = Colors.blue[200];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              isSenderMessage ? '$sender ($sender)' : '$senderDE ($sender)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDarkModeEnabled ? Colors.white : Colors.black,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  messageDE,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textDirection: isGermanRTL ? TextDirection.rtl : TextDirection.ltr,
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: message,
                      ),
                    ],
                  ),
                  textDirection: isPersian ? TextDirection.rtl : TextDirection.ltr,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              tts.speak(messageDE); // Speak the German message
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.volume_up, color: isDarkModeEnabled ? Colors.white : Colors.blue),
                  const SizedBox(width: 4),
                  Text(
                    'Play',
                    style: TextStyle(color: isDarkModeEnabled ? Colors.white : Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class ConversationPage extends StatefulWidget {
  static const RoutName = "/conversation";
  final int id;
  final String language;
  final String name;

  ConversationPage({
    required this.id,
    required this.language,
    required this.name,
  });

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final FlutterTts flutterTts = FlutterTts();
  List<ConversationModel> jsonData = [];

  @override
  void initState() {
    super.initState();
    _initTts(); // Initialize TTS settings, including language

    final topic = mapIdToTopic(widget.id);
    final _data = ConversationMethods(topic as List<Map<String, dynamic>>);
    jsonData = _data.getConversationData();
  }

  // Initialize TTS settings, including language
  Future<void> _initTts() async {
    await flutterTts.setLanguage('de-DE'); // Set German language
    await flutterTts.setPitch(1.0); // Set pitch level (adjust as needed)
  }

  @override
  void dispose() {
    // Stop the TTS engine when the page is disposed (navigating back)
    flutterTts.stop();
    super.dispose();
  }

  List mapIdToTopic(int id) {
    switch (id) {
      case 1:
        return doctor_visit_conversation;
      case 2:
        return dentist_visit_conversation;
      case 3:
        return pharmacy_conversation;
      case 4:
        return general_conversation;
      case 5:
        return general_conversation;
      case 6:
        return general_conversation;
      case 7:
        return general_conversation;
      case 8:
        return general_conversation;
      case 9:
        return bank_conversation;
      case 10:
        return immigration_conversation;
      case 11:
        return general_conversation;
      case 12:
        return general_conversation;
      case 13:
        return shopping_conversation;
      case 14:
        return apartment_conversation;
      case 15:
        return general_conversation;
      case 16:
        return general_conversation;
      case 17:
        return general_conversation;
      case 18:
        return general_conversation;
      case 19:
        return general_conversation;
      case 20:
        return general_conversation;
      case 21:
        return general_conversation;
      case 22:
        return job_interview_conversation;
      case 23:
        return general_conversation;
      case 24:
        return general_conversation;
      case 25:
        return general_conversation;
      case 26:
        return general_conversation;
      case 27:
        return general_conversation;
      case 28:
        return general_conversation;
      case 29:
        return general_conversation;
      case 30:
        return general_conversation;
      case 31:
        return general_conversation;
      case 32:
        return general_conversation;
      case 33:
        return food_conversation;
      case 34:
        return general_conversation;
      case 35:
        return general_conversation;
      case 36:
        return general_conversation;
      case 37:
        return general_conversation;
      case 38:
        return general_conversation;
      case 39:
        return general_conversation;
      case 40:
        return general_conversation;
      case 41:
        return airport_conversation;
      case 42:
        return hotel_conversation;
      case 43:
        return general_conversation;
      case 44:
        return general_conversation;
      case 45:
        return general_conversation;
      case 46:
        return general_conversation;
      default:
        throw Exception("Invalid topic ID");
    }
  }

  @override
  Widget build(BuildContext context) {
    String language = widget.language;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 8),
        child: ListView.builder(
          itemCount: jsonData.length,
          itemBuilder: (context, index) {
            ConversationModel currentMessage = jsonData[index];

            return WordListItem(
              senderDE: currentMessage.sender_de,
              messageDE: currentMessage.message_de,
              sender: (widget.language == "en")
                  ? currentMessage.sender_en
                  : currentMessage.sender_fa,
              message: (widget.language == "en")
                  ? currentMessage.message_en
                  : currentMessage.message_fa,
              language: language,
              tts: flutterTts,
            );
          },
        ),
      ),

    );
  }
}
