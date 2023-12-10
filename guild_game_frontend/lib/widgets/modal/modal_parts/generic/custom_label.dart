import 'package:flutter/material.dart';

class CustomLabel extends StatelessWidget {
  final String title;
  final String content;
  final TextAlign textAlign;

  const CustomLabel({
    Key? key,
    required this.title,
    required this.content,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$title: ',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white)),
          Expanded(
            child: Text(
              content,
              textAlign: textAlign,
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 16,
              ),
              softWrap: true, // Allows text wrapping
              overflow: TextOverflow.clip, // Clip the overflowed text
            ),
          ),
        ],
      ),
    );
  }
}
