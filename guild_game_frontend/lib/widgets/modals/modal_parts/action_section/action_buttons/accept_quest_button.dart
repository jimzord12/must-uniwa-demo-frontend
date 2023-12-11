import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class AcceptQuestButton extends StatefulWidget {
  final String walletAddress;
  final String questId;

  const AcceptQuestButton({
    super.key,
    required this.walletAddress,
    required this.questId,
  });

  @override
  _AcceptQuestButtonState createState() => _AcceptQuestButtonState();
}

class _AcceptQuestButtonState extends State<AcceptQuestButton> {
  final QuestProvider _questProvider = QuestProvider();
  bool isButtonEnabled = true;

  void _acceptQuest(BuildContext context) async {
    await _questProvider.acceptQuest(widget.walletAddress, widget.questId);
    Navigator.of(context).pop(); // Close current modal
  }

  @override
  Widget build(BuildContext context) {
    return ActionSectionButton(
      text: "Accept Quest",
      icon: Icons.add,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      onPressed: () => _acceptQuest(context),
    );
  }
}
