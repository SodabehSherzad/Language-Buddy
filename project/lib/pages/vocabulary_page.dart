import 'package:flutter/material.dart';

class VocabularyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vocabulary'),
          ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Expand or Collapse all words'),
                  Switch(
                    value: true,
                    onChanged: (bool value) {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    VocabularyItem(word: 'Der Arzt', translation: 'Doctor (male)'),
                    VocabularyItem(word: 'Die Ärztin', translation: 'Doctor (female)'),
                    VocabularyItem(word: 'Die Klinik', translation: 'Clinic'),
                    VocabularyItem(word: 'Das Krankenhaus', translation: 'Hospital'),
                    VocabularyItem(word: 'Der Patient', translation: 'Patient (male)'),
                    VocabularyItem(word: 'Die Patientin', translation: 'Patient (female)'),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.translate),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: '',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
    );
  }
}

class VocabularyItem extends StatelessWidget {
  final String word;
  final String translation;

  VocabularyItem({required this.word, required this.translation});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(word, style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translation),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.volume_up),
                      onPressed: () {
                        // Handle play audio
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.star_border),
                      onPressed: () {
                        // Handle favorite
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.expand_more),
                      onPressed: () {
                        // Handle expand/collapse
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

