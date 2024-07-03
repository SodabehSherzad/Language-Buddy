import 'package:flutter/material.dart';

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(word, style: TextStyle(fontWeight: FontWeight.bold)),

            Text(translation),
          ],
        ),
      ),
    );
  }
}