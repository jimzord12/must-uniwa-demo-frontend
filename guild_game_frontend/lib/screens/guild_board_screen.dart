import 'package:flutter/material.dart';
import 'package:guild_game_frontend/screens/loaded_screen.dart';
import 'package:micro_guild_game/screens/loaded_screen.dart';
import 'package:micro_guild_game/widgets/stayros130/custom_button.dart';

class GuildBoardScreen extends StatelessWidget {
  const GuildBoardScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guild Board'),
      ),
      body: SingleChildScrollView( // Wrap the Column in a SingleChildScrollView
        child: Center(
          child: Padding( // Wrap the Column in a Padding widget
      padding: const EdgeInsets.all(8.0), // Add padding here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(buttonText: 'TESTY', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadedScreen()));}),
          // Add more buttons here
        ],
      ),
    ),
        ),
      ),
    );
  }
}