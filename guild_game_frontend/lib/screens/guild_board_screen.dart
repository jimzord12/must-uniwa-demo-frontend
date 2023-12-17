import 'package:flutter/material.dart';
import 'package:guild_game_frontend/navigation/go_back_button.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:guild_game_frontend/widgets/modals/student/accept_quest_modal.dart';
import 'package:guild_game_frontend/widgets/modals/success_modal.dart';
import 'package:guild_game_frontend/widgets/modals/view_completed_quest_modal.dart';
import 'package:guild_game_frontend/widgets/stayros130/custom_button.dart';
import 'package:provider/provider.dart';

class GuildBoardScreen extends StatelessWidget {
  const GuildBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questProvider = Provider.of<QuestProvider>(context, listen: true);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    final List<dynamic> quests = questProvider.quests ?? [];

    double screenHeight = MediaQuery.of(context).size.height;

    Future<void> acceptQuest(String questId) async {
      try {
        await questProvider.acceptQuest(userProvider.pubAddress!, questId);
        await userProvider.fetchUserData(userProvider.pubAddress!);

        // if (ModalRoute.of(context)?.isCurrent ?? false) {
        showSuccessDialog(context,
            "You have successfully accepted the quest!\n You can now find it in the Current Quests menu.");

        // Navigator.of(context).pop(); // Close current modal
        // }
      } catch (e) {
        print('Failed to accept quest: $e');
        showErrorDialog(context, "Failed to accept quest. Please try again.");
        // Optionally, show an error dialog or snackbar
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    56), // Increased top padding
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: quests.isEmpty
                      ? [
                          SizedBox(height: screenHeight / 3),
                          const Text(
                            'There are no quests available at the moment',
                            style: TextStyle(
                              fontSize: 24,
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
                                  showAcceptQuestModal(
                                    context: context,
                                    walletAddress: userProvider.pubAddress!,
                                    questId: quest.id!,
                                    quest: quest,
                                    acceptQuest: acceptQuest,
                                  );
                                } else {
                                  showQuestDetailsModal(
                                    context: context,
                                    // walletAddress: userProvider.pubAddress!,
                                    questId: quest.id!,
                                    quest: quest,
                                  );
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
