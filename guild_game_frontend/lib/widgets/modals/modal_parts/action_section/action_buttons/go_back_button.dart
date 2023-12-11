import 'package:flutter/material.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionSectionButton(
      text: 'Go Back',
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icons.arrow_back,
      backgroundColor: Colors.amber.shade600,
      textColor: Colors.black,
    );
  }
}
