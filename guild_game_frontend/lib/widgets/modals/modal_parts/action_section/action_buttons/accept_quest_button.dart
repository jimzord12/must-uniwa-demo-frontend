import 'package:flutter/material.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class AcceptQuestButton extends StatelessWidget {
  final Function(String) acceptQuest;
  final String questId;

  const AcceptQuestButton({
    super.key,
    required this.acceptQuest,
    required this.questId,
  });

  @override
  Widget build(BuildContext context) {
    return ActionSectionButton(
      text: "Accept Quest",
      icon: Icons.add,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      onPressed: () => acceptQuest(questId),
    );
  }
}
