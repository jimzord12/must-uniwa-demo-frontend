import 'package:flutter/material.dart';

class QuestDescription extends StatelessWidget {
  final String title;
  final String content;
  final TextAlign textAlign;

  const QuestDescription({
    Key? key,
    required this.title,
    required this.content,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Padding inside the container
      margin: const EdgeInsets.symmetric(
          vertical: 4.0), // Space around the container
      decoration: BoxDecoration(
        color: Colors.grey.shade800, // Grey background color
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment
            .start, // Align text to the start of the container
        children: [
          Text(
            '$title:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0), // Spacing between title and content
          Text(
            content,
            textAlign: textAlign,
            style: const TextStyle(
                color: Colors.white,
                ), // Changed color to white for contrast
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
