import 'package:flutter/material.dart';
import 'package:micro_guild_game/widgets/stayros130/accepted_quest_modal.dart';

class CurrentQuestsScreen extends StatelessWidget {
  const CurrentQuestsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accepted Quests'),
      ),
      body: const SingleChildScrollView( // Wrap the Column in a SingleChildScrollView
        child: Padding( // Wrap the Column in a Padding widget
          padding: EdgeInsets.all(8.0), // Add padding here
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AcceptedQuestModal(
                  title: 'Current Quest Test',
                  skills: 'Java', xp: 420, description: 'testy'
                ),
                // Add more AcceptedQuestModal widgets here
              ],
            ),
          ),
        ),
      ),
    );
  }
}