import 'package:flutter/material.dart';

class ActionsSection extends StatelessWidget {
  final List<Widget> buttons;
  final Color backgroundColor; // Add this
  final double borderRadius; // Add this
  final double spaceBetweenButtons; // Add this

  const ActionsSection({
    super.key,
    required this.buttons,
    this.backgroundColor = Colors.transparent,
    // const Color.fromARGB(117, 195, 183, 21), // Default color
    this.borderRadius = 8.0, // Default radius
    this.spaceBetweenButtons = 12.0, // Default spacing
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      alignment: AlignmentDirectional.center, // Add padding if needed
      decoration: BoxDecoration(
        color: backgroundColor, // Use the passed background color
        borderRadius:
            BorderRadius.circular(borderRadius), // Use the passed border radius
        // Optionally, add a border, shadow, etc.
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Use spaceBetween
        children: _buildButtonsWithSpacing(), // Use the helper method
      ),
    );
  }

  List<Widget> _buildButtonsWithSpacing() {
    final List<Widget> buttonsWithSpacing = [];
    for (int i = 0; i < buttons.length; i++) {
      buttonsWithSpacing.add(buttons[i]);
      if (i != buttons.length - 1) {
        buttonsWithSpacing.add(SizedBox(height: spaceBetweenButtons));
      }
    }
    return buttonsWithSpacing;
  }
}
