import 'package:flutter/material.dart';
import 'package:guild_game_frontend/navigation/go_back_button.dart'; // Import your CustomGoBackButton
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/widgets/stayros130/custom_button.dart';
import 'package:provider/provider.dart';

class GuildBoardScreen extends StatelessWidget {
  const GuildBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final questProvider = Provider.of<QuestProvider>(context, listen: true);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    final List<dynamic> quests = questProvider.quests ?? [];

    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: CustomGoBackButton(
                icon: Icons.arrow_back,
                iconColor: Colors.black,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    48), // Adjust padding to prevent overlap
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
                                // Handle button press based on role
                              },
                            ),
                          );
                        }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
