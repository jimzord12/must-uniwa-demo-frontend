import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/widgets/modals/student/accept_quest_modal.dart';
import 'package:guild_game_frontend/widgets/modals/student/view_completed_quest_modal.dart';
import 'package:guild_game_frontend/widgets/stayros130/custom_button.dart';
import 'package:provider/provider.dart';

class GuildBoardScreen extends StatelessWidget {
  const GuildBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questProvider = Provider.of<QuestProvider>(context, listen: true);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    final List<dynamic> quests = userProvider.user!.ongoingQuests;

    double screenHeight = MediaQuery.of(context).size.height;

    print(
        "GuildBoardScreen - Rendered, Avail. Quests: ${questProvider.quests!.length}");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guild Board'),
      ),
      body: SingleChildScrollView(
        // Wrap the Column in a SingleChildScrollView
        child: Center(
          child: Padding(
            // Wrap the Column in a Padding widget
            padding: const EdgeInsets.all(8.0), // Add padding here
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (quests.isEmpty) ...[
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
                  ] else // questProvider.quests!.map((quest) {
                    ...questProvider.quests!.map((quest) {
                      return Padding(
                        // Add padding to create a gap between CustomButton widgets
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
                                );
                              } else {
                                showQuestDetailsModal(
                                  context: context,
                                  walletAddress: userProvider.pubAddress!,
                                  questId: quest.id!,
                                  quest: quest,
                                );
                              }
                            }
                            ),
                      );
                    }),
                ]

                // questProvider.quests!.map((quest) {
                //   return Padding(
                //     // Add padding to create a gap between CustomButton widgets
                //     padding: const EdgeInsets.symmetric(vertical: 12.0),
                //     child: CustomButton(
                //         buttonText: quest.title,
                //         onPressed: () {
                //           if (userProvider.user!.role == 'student') {
                //             showAcceptQuestModal(
                //               context: context,
                //               walletAddress: userProvider.pubAddress!,
                //               questId: quest.id!,
                //               quest: quest,
                //             );
                //           } else {
                //             showQuestDetailsModal(
                //               context: context,
                //               walletAddress: userProvider.pubAddress!,
                //               questId: quest.id!,
                //               quest: quest,
                //             );
                //           }
                //         }),
                //   );
                // }).toList(),

                ),
          ),
        ),
      ),
    );
  }
}
