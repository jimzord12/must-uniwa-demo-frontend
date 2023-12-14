import 'package:flutter/material.dart';
import 'package:guild_game_frontend/models/ranks.dart';
import 'package:guild_game_frontend/navigation/custom_navigation.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/screens/current_quests_screen.dart';
import 'package:guild_game_frontend/screens/guild_board_screen.dart';
import 'package:guild_game_frontend/screens/pending_quests_screen.dart';
import 'package:guild_game_frontend/screens/portfolio_screen.dart';
import 'package:guild_game_frontend/screens/rejection_quests_screen.dart';
import 'package:guild_game_frontend/widgets/stayros130/custom_button.dart';
import 'package:provider/provider.dart';

class StudentMainScreen extends StatelessWidget {
  StudentMainScreen({super.key});

  Color pendingNotificationColor = Colors.red;
  Color rejectedNotificationColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);

    if (userProvider.user!.pendingReviewQuests.isEmpty) {
      pendingNotificationColor = Colors.transparent;
    }

    if (userProvider.user!.rejectedQuests.isEmpty) {
      rejectedNotificationColor = Colors.transparent;
    }

    GuildGameNavigator? navigator = GuildGameNavigator.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Rank: ${Ranks().getRank(userProvider.user!.xp).toString().split('.').last}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              buttonText: 'Current Quests',
              onPressed: () {
                navigator?.pushScreen(
                    const CurrentQuestsScreen()); // Using custom navigation
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Stack(
              children: [
                CustomButton(
                  buttonText: 'Pending Quests',
                  onPressed: () {
                    navigator?.pushScreen(
                        const PendingQuestsScreen()); // Using custom navigation
                  },
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: pendingNotificationColor,
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
            SizedBox(height: MediaQuery.of(context).size.height / 20),
            Stack(
              children: [
                CustomButton(
                  buttonText: 'Rejected Quests',
                  onPressed: () {
                    navigator?.pushScreen(
                        const RejectionQuestsScreen()); // Using custom navigation
                  },
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: rejectedNotificationColor,
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
            SizedBox(height: MediaQuery.of(context).size.height / 20),
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
          ],
        ),
      ),
    );
  }
}
