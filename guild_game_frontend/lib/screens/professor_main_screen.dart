import 'package:flutter/material.dart';
import 'package:guild_game_frontend/models/ranks.dart';
import 'package:guild_game_frontend/navigation/custom_navigation.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/screens/current_quests_screen.dart';
import 'package:guild_game_frontend/screens/guild_board_screen.dart';
import 'package:guild_game_frontend/screens/portfolio_screen.dart';
import 'package:guild_game_frontend/widgets/modals/professor/create_quest_modal.dart';
import 'package:guild_game_frontend/widgets/stayros130/custom_button.dart';
import 'package:provider/provider.dart';

class ProfessorMainScreen extends StatelessWidget {
  ProfessorMainScreen({Key? key}) : super(key: key);

  Color notificationColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);

    if (userProvider.user!.pendingReviewQuests.isEmpty) {
      notificationColor = Colors.transparent;
    }

    GuildGameNavigator? navigator = GuildGameNavigator.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navigator?.popScreen(); // Using custom navigation to pop
          },
        ),
        title: Text(
            'Rank: ${Ranks().getRank(userProvider.user!.xp).toString().split('.').last}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              buttonText: 'Create Quest',
              onPressed: () =>
                  showCreateQuestModal(context, userProvider.pubAddress!),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            CustomButton(
              buttonText: 'Current Quests',
              onPressed: () {
                navigator?.pushScreen(
                    const CurrentQuestsScreen()); // Using custom navigation
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            // ... rest of the buttons with navigator?.pushScreen ...
            CustomButton(
              buttonText: 'Available Quests',
              onPressed: () {
                navigator
                    ?.pushScreen(GuildBoardScreen()); // Using custom navigation
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            CustomButton(
              buttonText: 'History of Quests',
              onPressed: () {
                navigator
                    ?.pushScreen(PortfolioScreen()); // Using custom navigation
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            // ... other buttons ...
          ],
        ),
      ),
    );
  }
}
