import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class QuestNeedsRevisiontButton extends StatelessWidget {
  final QuestProvider questProvider = QuestProvider();
  final VoidCallback onCreate; // A callback function for creation

  // final String title;
  // final String desc;
  // final String requiredSkills;
  // final String xp;
  // final String createdBy;

  QuestNeedsRevisiontButton({
    super.key,
    required this.onCreate,
    // required this.title,
    // required this.desc,
    // required this.requiredSkills,
    // required this.xp,
    // required this.createdBy,
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

// class QuestNeedsRevisiontButton extends StatelessWidget {
//   final String walletAddress;
//   final String questId;
//   final QuestProvider _questProvider = QuestProvider();
//   final String rejectionReason;

//   QuestNeedsRevisiontButton({
//     super.key,
//     required this.walletAddress,
//     required this.questId,
//     required this.rejectionReason,
//   });

//   Future<void> _needsRevision(BuildContext context) async {
//     try {
//       await _questProvider.needsRevision(
//           rejectionReason, walletAddress, questId);
//       if (ModalRoute.of(context)?.isCurrent ?? false) {
//         showSuccessDialog(
//             context, "The Quest was successfully sent back for revison.");
//         Navigator.of(context).pop(); // Close current modal
//       }
//     } catch (e) {
//       print('Failed to retry quest: $e');
//       showErrorDialog(
//           context, "Failed to sent back quest for revison. Please try again.");
//       // Optionally, show an error dialog or snackbar
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ActionSectionButton(
//       text: "Send Back for Revision",
//       icon: Icons.send,
//       backgroundColor: Colors.blue.shade700,
//       textColor: Colors.white,
//       onPressed: () => _needsRevision(context),
//     );
//   }
// }
