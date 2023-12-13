import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';
import 'package:guild_game_frontend/widgets/modals/success_modal.dart';
import 'package:provider/provider.dart';

class ForfeitQuestButton extends StatelessWidget {
  final String walletAddress;
  final String questId;

  const ForfeitQuestButton({
    super.key,
    required this.walletAddress,
    required this.questId,
  });

  @override
  Widget build(BuildContext context) {
    final questProvider = Provider.of<QuestProvider>(context, listen: false);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    Future<void> forfeitQuest(BuildContext context) async {
      try {
        await questProvider.forfeitQuest(walletAddress, questId);
        await userProvider.fetchUserData(walletAddress);

        // if (ModalRoute.of(context)?.isCurrent ?? false) {
        showSuccessDialog(context, "The Quest was successfully forfeited.");
        // Navigator.of(context).pop(); // Close current modal
        // }
      } catch (e) {
        print('Failed to retry quest: $e');
        showErrorDialog(context, "Failed to forfeit quest. Please try again.");
        // Optionally, show an error dialog or snackbar
      }
    }

    return ActionSectionButton(
      text: "Forfeit Quest",
      icon: Icons.cancel,
      backgroundColor: Colors.red.shade700,
      textColor: Colors.white,
      onPressed: () => forfeitQuest(context),
    );
  }
}
