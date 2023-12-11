import 'package:flutter/material.dart';

class QuestTitle extends StatelessWidget {
  final String title;
  final String content;
  final TextAlign textAlign;
  final Color contentColor;

  const QuestTitle({
    Key? key,
    required this.title,
    required this.content,
    this.contentColor = Colors.amber,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        // Change to Column for vertical arrangement
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center, // Center the Column
        children: [
          Text(content,
              textAlign: textAlign,
              style: TextStyle(
                color: contentColor,
                fontSize: 20,
              ),
              softWrap: true),
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white)),
        ],
      ),
    );
  }
}
