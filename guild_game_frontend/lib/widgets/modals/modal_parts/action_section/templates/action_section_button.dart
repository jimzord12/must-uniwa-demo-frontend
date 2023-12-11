import 'package:flutter/material.dart';

class ActionSectionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon; // New property to hold the icon
  final Color backgroundColor; // New property to hold the background color
  final Color textColor; // New property to hold the text color

  const ActionSectionButton({
    super.key,
    // Fix the super.key parameter
    required this.text,
    required this.onPressed,
    this.icon, // Optional icon parameter
    this.backgroundColor =
        const Color.fromARGB(255, 187, 239, 242), // Default background color
    this.textColor = const Color.fromARGB(255, 9, 11, 83), // Default text color
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        minimumSize: const Size(280, 50), // Set the fixed width and height
      ),
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              MainAxisAlignment.start, // Align elements to the left
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align elements to the top
          children: [
            if (icon != null) // Render the icon if provided
              Icon(icon, color: textColor),

            const SizedBox(width: 16), // Add some spacing between icon and text

            Flexible(
              child: Text(
                text,
                style: TextStyle(color: textColor),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start, // Align text to the start (left)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
