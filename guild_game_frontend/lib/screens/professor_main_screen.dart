import 'package:flutter/material.dart';
import 'package:micro_guild_game/screens/portfolio_screen.dart';
import 'package:micro_guild_game/screens/pending_quests_screen.dart';
import 'package:micro_guild_game/widgets/stayros130/custom_button.dart';
import 'package:micro_guild_game/screens/loaded_screen.dart';
import 'package:micro_guild_game/widgets/stayros130/ranks.dart';

class ProfessorMainScreen extends StatelessWidget {
  ProfessorMainScreen({super.key});

  int dummyXp = 420;
  bool notification = true;
  Color notificationColor = Colors.red;

  @override
  build(BuildContext context) {
    if (!notification) notificationColor = Colors.transparent;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Rank: ${Ranks().getRank(dummyXp).toString().split('.').last}'), // Get rank from xp
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              buttonText: 'Create Quest',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoadedScreen()));
              },
            ),
            SizedBox(
                height:MediaQuery.of(context).size.height / 20), // Add some space
            Stack(
              children: [
                CustomButton(
                  buttonText: 'Pending Quests',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PendingQuestsScreen()));
                  },
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: notificationColor,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 38,
                      minHeight: 38,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height/20), // Add some space
            CustomButton(
              buttonText: 'History of Quests',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PortfolioScreen()));
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height/20), // Add some space
          ],
        ),
      ),
    );
  }
}