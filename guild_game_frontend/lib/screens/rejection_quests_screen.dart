import 'package:flutter/material.dart';
import 'package:guild_game_frontend/navigation/go_back_button.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:guild_game_frontend/widgets/modals/student/retry_quest_modal.dart';
import 'package:guild_game_frontend/widgets/modals/success_modal.dart';
import 'package:guild_game_frontend/widgets/stayros130/custom_button.dart';
import 'package:provider/provider.dart';

class RejectionQuestsScreen extends StatelessWidget {
  const RejectionQuestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final QuestProvider questProvider =
        Provider.of<QuestProvider>(context, listen: true);

    final String userRole = userProvider.user!.role;
    final List<dynamic> quests = userProvider.user!.rejectedQuests;

    double screenHeight = MediaQuery.of(context).size.height;

    Future<void> retryQuest(String questId) async {
      final String address = userProvider.pubAddress!;
      try {
        await questProvider.retryQuest(address, questId);
        await userProvider.fetchUserData(address);

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

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    48), // Adjust padding to prevent overlap
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (quests.isEmpty) SizedBox(height: screenHeight / 3),
                    if (quests.isEmpty)
                      const Text(
                        'There are no Rejected Quests at the moment.',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(125, 228, 220, 220),
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ...quests
                      ..map<Widget>((quest) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: CustomButton(
                            buttonText: quest.title,
                            onPressed: () {
                              if (userRole == 'student') {
                                showRetryQuestModal(
                                    context,
                                    userProvider.pubAddress!,
                                    quest.id!,
                                    quest,
                                    retryQuest);
                              } else {
                                showErrorDialog(context,
                                    "You are not a student. You are not supposed to be here.");
                              }
                            },
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context)
                .padding
                .top, // Align with top of screen, accounting for status bar
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
