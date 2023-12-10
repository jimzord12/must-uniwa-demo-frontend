import 'package:flutter/material.dart';

class ActionSectionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon; // New property to hold the icon
  final Color backgroundColor; // New property to hold the background color
  final Color textColor; // New property to hold the text color

  const ActionSectionButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon, // Optional icon parameter
    this.backgroundColor =
        const Color.fromARGB(255, 187, 239, 242), // Default background color
    this.textColor = const Color.fromARGB(255, 9, 11, 83), // Default text color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) // Render the icon if provided
            Icon(icon, color: textColor),
          const SizedBox(width: 22), // Add some spacing between icon and text
          Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
