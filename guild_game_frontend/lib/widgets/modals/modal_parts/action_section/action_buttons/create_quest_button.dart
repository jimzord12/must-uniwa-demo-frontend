import 'package:flutter/material.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class CreateQuestButton extends StatelessWidget {
  final VoidCallback onCreate; // A callback function for creation

  const CreateQuestButton({
    super.key,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return ActionSectionButton(
      text: "Create Quest",
      icon: Icons.add,
      onPressed: onCreate,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
}
