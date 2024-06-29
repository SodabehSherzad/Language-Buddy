import 'package:flutter/material.dart';

class VocabularyItem extends StatelessWidget {
  final String word;
  final String translation;

  VocabularyItem({required this.word, required this.translation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(word, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(translation),
        ],
      ),
    );
  }
}