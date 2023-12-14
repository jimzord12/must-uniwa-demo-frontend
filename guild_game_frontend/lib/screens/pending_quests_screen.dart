import 'package:flutter/material.dart';
import 'package:guild_game_frontend/navigation/go_back_button.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:guild_game_frontend/widgets/modals/professor/manage_submitted_quest_modal.dart';
import 'package:guild_game_frontend/widgets/modals/student/view_completed_quest_modal.dart';
import 'package:guild_game_frontend/widgets/modals/success_modal.dart';
import 'package:guild_game_frontend/widgets/stayros130/custom_button.dart';
import 'package:provider/provider.dart';

class PendingQuestsScreen extends StatelessWidget {
  const PendingQuestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    final QuestProvider questProvider =
        Provider.of<QuestProvider>(context, listen: true);

    final List<dynamic> quests = userProvider.user!.pendingReviewQuests;
    double screenHeight = MediaQuery.of(context).size.height;

    Future<void> needsRevision(
        {required String rejectionReason, required String questId}) async {
      try {
        print('-  rejectionReason: $rejectionReason');
        await questProvider.needsRevision(
            rejectionReason, userProvider.pubAddress!, questId);
        // if (ModalRoute.of(context)?.isCurrent ?? false) {
        showSuccessDialog(
            context, "The Quest was successfully sent back for revison.");
        // Navigator.of(context).pop(); // Close current modal
        // }
      } catch (e) {
        print('Failed to retry quest: $e');
        showErrorDialog(context,
            "Failed to sent back quest for revision. Rejection Reason is mandatory. Please try again.");
      }
    }

    Future<void> completeQuest(String questId) async {
      try {
        await questProvider.completeQuest(userProvider.pubAddress!, questId);
        await userProvider.fetchUserData(userProvider.pubAddress!);
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

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 56),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: quests.isEmpty
                      ? [
                          SizedBox(height: screenHeight / 3),
                          const Text(
                            'You do not have any quests pending',
                            style: TextStyle(
                              fontSize: 21,
                              color: Color.fromARGB(127, 255, 255, 255),
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ]
                      : quests.map<Widget>((quest) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: CustomButton(
                              buttonText: quest.title,
                              onPressed: () {
                                if (userProvider.user!.role == 'student') {
                                  showQuestDetailsModal(
                                      context: context,
                                      walletAddress: userProvider.pubAddress!,
                                      questId: quest.id,
                                      quest: quest);
                                } else {
                                  showQuestManagerModal(
                                      needsRevision: needsRevision,
                                      completeQuest: completeQuest,
                                      context: context,
                                      walletAddress: userProvider.pubAddress!,
                                      questId: quest.id,
                                      quest: quest,
                                      pdfName: quest.pdfFilename);
                                }
                              },
                            ),
                          );
                        }).toList(),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            child: const SafeArea(
              child: CustomGoBackButton(
                icon: Icons.arrow_back,
                iconColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
