import 'package:flutter/material.dart';
import 'package:guild_game_frontend/models/ranks.dart';
import 'package:guild_game_frontend/navigation/go_back_button.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/widgets/modals/professor/view_completed_quest_modal.dart';
import 'package:guild_game_frontend/widgets/stayros130/custom_button.dart';
import 'package:provider/provider.dart';

class PortfolioScreen extends StatelessWidget {
  PortfolioScreen({super.key});

  String skillColumn1 = '';
  String skillColumn2 = '';

  @override
  Widget build(BuildContext context) {
    final questProvider = Provider.of<QuestProvider>(context, listen: true);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);

    List<String> userSkills = userProvider.user!.skills;

    final String userRole = userProvider.user!.role;
    final int userXP = userProvider.user!.xp;
    final int completedQuestsAmount = userProvider.user!.successfulQuests;
    final List<dynamic> completedQuests = userProvider.user!.completedQuests;

    // Splitting skills into two columns
    for (var i = 0; i < userSkills.length; i++) {
      if (i < userSkills.length / 2) {
        skillColumn1 += '${userSkills[i]}\n';
      } else {
        skillColumn2 += '${userSkills[i]}\n';
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 56),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    child: ListTile(
                      title: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'RANK: ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            TextSpan(
                                text: Ranks()
                                    .getRank(userXP)
                                    .toString()
                                    .split('.')
                                    .last,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: ListTile(
                      //title: Text('Total XP: ${dummyXp.toString()}'),
                      title: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Total XP: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                                text: userXP.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: ListTile(
                      title: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Quest completed in total: ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                                text: completedQuestsAmount.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: ListTile(
                      title: const Text('Available Skills:'),
                      subtitle: Row(
                        children: userSkills.isEmpty
                            ? [const Text("You have no available skills")]
                            : [
                                Column(children: [
                                  Text(skillColumn1),
                                ]),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Text(skillColumn2),
                                  ],
                                ))
                              ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'All the completed Quests:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  if (completedQuests.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'You have no completed quests',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  if (completedQuests.isNotEmpty)
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemCount: userProvider.user!.completedQuests.length,
                        itemBuilder: (context, index) {
                          final quest =
                              userProvider.user!.completedQuests[index];
                          return CustomButton(
                              buttonText: quest.title,
                              onPressed: () {
                                showQuestDetailsModal(
                                    context: context,
                                    walletAddress: userProvider.pubAddress!,
                                    questId: quest.id,
                                    quest: quest);
                              });
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
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
