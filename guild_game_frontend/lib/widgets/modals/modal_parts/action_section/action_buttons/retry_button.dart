import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';
import 'package:guild_game_frontend/widgets/modals/success_modal.dart';

class RetryQuestButton extends StatelessWidget {
  final String walletAddress;
  final String questId;
  final QuestProvider _questProvider = QuestProvider();

  RetryQuestButton({
    super.key,
    required this.walletAddress,
    required this.questId,
  });

  Future<void> _retryQuest(BuildContext context) async {
    try {
      await _questProvider.retryQuest(walletAddress, questId);
      // if (ModalRoute.of(context)?.isCurrent ?? false) {
      showSuccessDialog(
          context, "The Quest was successfully re-assigned to you.");
      // Navigator.of(context).pop(); // Close current modal
      // }
    } catch (e) {
      print('Failed to retry quest: $e');
      showErrorDialog(context, "Failed to retry quest. Please try again.");
      // Optionally, show an error dialog or snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    return ActionSectionButton(
      text: "Retry Quest",
      icon: Icons.refresh_outlined,
      backgroundColor: Colors.blue.shade700,
      textColor: Colors.white,
      onPressed: () => _retryQuest(context),
    );
  }
}
