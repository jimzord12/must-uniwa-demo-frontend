import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';
import 'package:guild_game_frontend/widgets/modals/success_modal.dart';

class CompleteQuestButton extends StatelessWidget {
  final String walletAddress;
  final String questId;
  final QuestProvider _questProvider = QuestProvider();

  CompleteQuestButton({
    super.key,
    required this.walletAddress,
    required this.questId,
  });

  Future<void> _completeQuest(BuildContext context) async {
    try {
      await _questProvider.completeQuest(walletAddress, questId);
      // if (ModalRoute.of(context)?.isCurrent ?? false) {
      showSuccessDialog(context,
          "Congratulation! The Quest was successfully completed. It shall forever be stored inside the unbreakable blockchain's blocks. ");
      // Navigator.of(context).pop(); // Close current modal
      // }
    } catch (e) {
      print('Failed to complete the quest: $e');
      showErrorDialog(context, "Failed to complete quest. Please try again.");
      // Optionally, show an error dialog or snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionSectionButton(
      text: "Complete Quest",
      icon: Icons.check,
      backgroundColor: Colors.green.shade700,
      textColor: Colors.white,
      onPressed: () => _completeQuest(context),
    );
  }
}
