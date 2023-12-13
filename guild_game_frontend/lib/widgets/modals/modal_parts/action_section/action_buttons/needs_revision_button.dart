import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class QuestNeedsRevisiontButton extends StatelessWidget {
  final QuestProvider questProvider = QuestProvider();
  final VoidCallback onCreate; // A callback function for creation

  QuestNeedsRevisiontButton({
    super.key,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return ActionSectionButton(
      text: "Send Back for Revision",
      icon: Icons.send,
      backgroundColor: Colors.red.shade700,
      textColor: Colors.white,
      onPressed: onCreate,
    );
  }
}
