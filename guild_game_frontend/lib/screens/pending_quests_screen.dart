import 'package:flutter/material.dart';
import 'package:micro_guild_game/screens/loaded_screen.dart';
import 'package:micro_guild_game/widgets/stayros130/custom_button.dart';

class PendingQuestsScreen extends StatelessWidget {
  const PendingQuestsScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Quests'),
      ),
      body: SingleChildScrollView( // Wrap the Column in a SingleChildScrollView
        child: Center(
          child: Padding( // Wrap the Column in a Padding widget
      padding: const EdgeInsets.all(8.0), // Add padding here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(buttonText: 'TESTY', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadedScreen()));}),
          SizedBox(height: 20),
          CustomButton(buttonText: 'TESTY 1', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadedScreen()));}),
          SizedBox(height: 20),
          CustomButton(buttonText: 'TESTY 2', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadedScreen()));}),
          SizedBox(height: 20),
          CustomButton(buttonText: 'TESTY 3', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadedScreen()));}),
          SizedBox(height: 20),
          CustomButton(buttonText: 'TESTY 4', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadedScreen()));}),
          SizedBox(height: 20),
          CustomButton(buttonText: 'TESTY 5', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadedScreen()));}),
          SizedBox(height: 20),
          CustomButton(buttonText: 'TESTY 6', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadedScreen()));}),
          SizedBox(height: 20),
          CustomButton(buttonText: 'TESTY 7', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadedScreen()));}),
          SizedBox(height: 20),
          CustomButton(buttonText: 'TESTY 8', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadedScreen()));}),
          SizedBox(height: 20),
          CustomButton(buttonText: 'TESTY 9', onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const LoadedScreen()));}),
         ],
      ),
    ),
        ),
      ),
    );
  }
}