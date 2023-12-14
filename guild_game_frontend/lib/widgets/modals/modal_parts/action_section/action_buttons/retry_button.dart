import 'package:flutter/material.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class RetryQuestButton extends StatelessWidget {
  final VoidCallback onCreate;

  const RetryQuestButton({
    super.key,
    required this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    // final questProvider = Provider.of<QuestProvider>(context, listen: false);
    // final UserProvider userProvider =
    //     Provider.of<UserProvider>(context, listen: false);

    // Future<void> retryQuest(BuildContext context) async {
    //   try {
    //     await questProvider.retryQuest(walletAddress, questId);
    //     await userProvider.fetchUserData(walletAddress);

    //     // if (ModalRoute.of(context)?.isCurrent ?? false) {
    //     showSuccessDialog(
    //         context, "The Quest was successfully re-assigned to you.");
    //     // Navigator.of(context).pop(); // Close current modal
    //     // }
    //   } catch (e) {
    //     print('Failed to retry quest: $e');
    //     showErrorDialog(context, "Failed to retry quest. Please try again.");
    //     // Optionally, show an error dialog or snackbar
    //   }
    // }

    return ActionSectionButton(
      text: "Retry Quest",
      icon: Icons.refresh_outlined,
      backgroundColor: Colors.blue.shade700,
      textColor: Colors.white,
      onPressed: onCreate,
    );
  }
}
