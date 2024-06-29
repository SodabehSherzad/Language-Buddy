import 'package:flutter/material.dart';

import 'item_page.dart';
import 'vocabulary_item.dart';

class VocabularyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vocabulary'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
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
    );
  }
}

