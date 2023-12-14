import 'package:flutter/material.dart';
import 'package:guild_game_frontend/navigation/go_back_button.dart';
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
    final List<dynamic> quests = userProvider.user!.ongoingQuests;

    double screenHeight = MediaQuery.of(context).size.height;

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
              children: [
                if (quests.isEmpty)
                  const CustomGoBackButton(
                    icon: Icons.arrow_back,
                    iconColor: Colors.black,
                  ),
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
                if (quests.isNotEmpty)
                  const CustomGoBackButton(icon: Icons.arrow_back),
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
    );
  }
}
