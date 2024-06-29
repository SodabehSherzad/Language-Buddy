import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class WordListItem extends StatelessWidget {
  final String senderDE;
  final String messageDE;
  final String sender;
  final String message;
  final FlutterTts tts;

  WordListItem({
    required this.senderDE,
    required this.messageDE,
    required this.sender,
    required this.message,
    required this.tts,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            senderDE,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  messageDE,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          InkWell(
            onTap: () {
              tts.speak(messageDE); // Speak the German message
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.volume_up, color: Colors.blue),
                SizedBox(width: 4),
                Text(
                  'Play',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConversationPage extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context) {
    // Placeholder data
    List<Map<String, String>> conversationData = [
      {
        'senderDE': 'Sender in German',
        'messageDE': 'Message in German',
        'sender': 'Sender in English',
        'message': 'Message in English',
      },
      {
        'senderDE': 'Another Sender in German',
        'messageDE': 'Another Message in German',
        'sender': 'Another Sender in English',
        'message': 'Another Message in English',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Conversation Page'),
      ),
      body: ListView.builder(
        itemCount: conversationData.length,
        itemBuilder: (context, index) {
          return WordListItem(
            senderDE: conversationData[index]['senderDE']!,
            messageDE: conversationData[index]['messageDE']!,
            sender: conversationData[index]['sender']!,
            message: conversationData[index]['message']!,
            tts: flutterTts,
          );
        },
      ),
    );
  }
}
