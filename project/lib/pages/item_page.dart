import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'conversation_page.dart';
import 'quiz_page.dart';
import 'vocabulary_page.dart';

class ItemPage extends StatefulWidget {
  static const RoutName = "/item";
  final String language;
  final bool isRandom;
  final bool isExpansionEnabled;
  final bool isTtsEnabled;
  final selectedTopic;

  ItemPage({
    required this.isRandom,
    required this.language,
    this.selectedTopic,
    required this.isExpansionEnabled,
    required this.isTtsEnabled,
  });

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {

  @override
  Widget build(BuildContext context) {
    // Ensure selectedTopic is not null
    if (widget.selectedTopic == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error: Selected topic is null'),
        ),
      );
    }

    // Extract necessary variables
    String language = widget.language;
    bool isRandom = widget.isRandom;
    final topic = widget.selectedTopic;
    String name = (language == "en") ? topic.name_en : topic.name_fa;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(child: Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          automaticallyImplyLeading: false,
          title: Text(name),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Vocabulary",
              ),
              Tab(
                text: "Conversation",
              ),
              Tab(
                text: "Test",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            VocabularyPage(
              isRandom: isRandom,
              isExpansionEnabled: widget.isExpansionEnabled,
              isTtsEnabled: widget.isTtsEnabled,
              language: language,
              selectedTopic: topic,
            ),
            ConversationPage(
              id: widget.selectedTopic.id,
              language: language,
              name: name,
            ),
            QuizPage(
              id: widget.selectedTopic.id,
              language: language,
              name: name,
            )
          ],
        ),
      ),
    );
  }
}
