import 'package:flutter/material.dart';
import 'package:guild_game_frontend/navigation/go_back_button.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/widgets/modals/professor/delete_quest_modal.dart';
import 'package:guild_game_frontend/widgets/modals/student/submit_or_forfeit_quest_modal.dart';
import 'package:guild_game_frontend/widgets/stayros130/custom_button.dart';
import 'package:provider/provider.dart';

class CurrentQuestsScreen extends StatelessWidget {
  const CurrentQuestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final String userRole = userProvider.user!.role;
    final List<dynamic> quests = userProvider.user!.ongoingQuests;

    double screenHeight = MediaQuery.of(context).size.height;

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
                        'You have not accepted any quests',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(125, 228, 220, 220),
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ...quests.map<Widget>((quest) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: CustomButton(
                          buttonText: quest.title,
                          onPressed: () {
                            if (userRole == 'student') {
                              showSubmitOrForfeitQuestModal(
                                context,
                                userProvider.pubAddress!,
                                quest.id!,
                                quest,
                              );
                            } else {
                              showDeleteQuestModal(
                                context: context,
                                walletAddress: userProvider.pubAddress!,
                                questId: quest.id!,
                                quest: quest,
                              );
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
            child: SafeArea(
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
