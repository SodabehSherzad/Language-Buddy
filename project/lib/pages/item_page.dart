import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'conversation_page.dart';
import 'quiz_page.dart';
import 'vocabulary_page.dart';

class ItemPage extends StatefulWidget {

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness:
            Brightness.light, //<-- For Android SEE HERE (dark icons)
            statusBarBrightness:
            Brightness.light, //<-- For iOS SEE HERE (dark icons)
          ),
          automaticallyImplyLeading: false,
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
            ),
            ConversationPage(),
            QuizPage(
            )
          ],
        ),
      ),
    );
  }
}
