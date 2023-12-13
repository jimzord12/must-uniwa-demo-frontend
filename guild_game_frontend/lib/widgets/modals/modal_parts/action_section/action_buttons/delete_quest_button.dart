import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';
import 'package:guild_game_frontend/widgets/modals/success_modal.dart';
import 'package:provider/provider.dart';

class DeleteQuestButton extends StatelessWidget {
  final String walletAddress;
  final String questId;
  // final QuestProvider _questProvider = QuestProvider();

  DeleteQuestButton({
    super.key,
    required this.walletAddress,
    required this.questId,
  });

  @override
  Widget build(BuildContext context) {
    final questProvider = Provider.of<QuestProvider>(context, listen: false);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);

    Future<void> deleteQuest(BuildContext context) async {
      try {
        await questProvider.deleteQuest(walletAddress, questId);
        await userProvider.fetchUserData(walletAddress);
        // if (ModalRoute.of(context)?.isCurrent ?? false) {
        showSuccessDialog(context, "You have successfully deleted the quest!");
        // Navigator.of(context).pop(); // Close current modal
        // }
      } catch (e) {
        print('Failed to delete quest: $e');
        showErrorDialog(context, "Failed to delete quest. Please try again.");
        // Optionally, show an error dialog or snackbar
      }
    }

    return ActionSectionButton(
      text: "Delete Quest",
      icon: Icons.delete,
      backgroundColor: Colors.red.shade700,
      textColor: Colors.white,
      onPressed: () => deleteQuest(context),
    );
  }
}
