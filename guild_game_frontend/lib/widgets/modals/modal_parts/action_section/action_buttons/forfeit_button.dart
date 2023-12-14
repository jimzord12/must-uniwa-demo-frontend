import 'package:flutter/material.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class ForfeitQuestButton extends StatelessWidget {
  final VoidCallback onCreate;

  const ForfeitQuestButton({
    required this.onCreate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final questProvider = Provider.of<QuestProvider>(context, listen: false);
    // final UserProvider userProvider =
    //     Provider.of<UserProvider>(context, listen: false);

    // Future<void> forfeitQuest(BuildContext context) async {
    //   try {
    //     await questProvider.forfeitQuest(walletAddress, questId);
    //     await userProvider.fetchUserData(walletAddress);

    //     // if (ModalRoute.of(context)?.isCurrent ?? false) {
    //     showSuccessDialog(context, "The Quest was successfully forfeited.");
    //     // Navigator.of(context).pop(); // Close current modal
    //     // }
    //   } catch (e) {
    //     print('Failed to retry quest: $e');
    //     showErrorDialog(context, "Failed to forfeit quest. Please try again.");
    //     // Optionally, show an error dialog or snackbar
    //   }
    // }

    return ActionSectionButton(
      text: "Forfeit Quest",
      icon: Icons.cancel,
      backgroundColor: Colors.red.shade700,
      textColor: Colors.white,
      onPressed: onCreate,
    );
  }
}
