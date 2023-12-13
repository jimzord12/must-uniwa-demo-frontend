import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/widgets/modals/professor/delete_quest_modal.dart';
import 'package:guild_game_frontend/widgets/modals/student/submit_or_forfeit_quest_modal.dart';
import 'package:guild_game_frontend/widgets/stayros130/custom_button.dart';
import 'package:provider/provider.dart';

class CurrentQuestsScreen extends StatelessWidget {
  const CurrentQuestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final String userRole = userProvider.user!.role;

    return Scaffold(
      appBar: AppBar(
        title:
            Text(userRole == 'student' ? 'Accepted Quests' : 'Created Quests'),
      ),
      body: SingleChildScrollView(
        // Wrap the Column in a SingleChildScrollView
        child: Padding(
          // Wrap the Column in a Padding widget
          padding: const EdgeInsets.all(8.0), // Add padding here
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: userProvider.user!.ongoingQuests.map<Widget>((quest) {
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
              }).toList(),

              // userProvider!.user!.ongoingQuests.map((quest) {
              //   return (
              //     buttonText: quest.title,
              //     onPressed: () => showAcceptQuestModal(
              //         context: context,
              //         walletAddress: userProvider.pubAddress!,
              //         questId: quest.id!,
              //         quest: quest),
              //   );
              // }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
