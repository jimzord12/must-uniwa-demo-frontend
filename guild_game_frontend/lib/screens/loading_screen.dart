import 'package:flutter/material.dart';
import 'package:guild_game_frontend/models/roles.dart';
import 'package:guild_game_frontend/navigation/custom_navigation.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/screens/professor_main_screen.dart';
import 'package:guild_game_frontend/screens/student_main_screen.dart';
import 'package:guild_game_frontend/services/initialization.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  final String privateKey;
  final Roles role;

  const LoadingScreen({Key? key, required this.privateKey, required this.role})
      : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    initializeUserData();
  }

  Future<void> initializeUserData() async {
    final wasSuccessful = await initializeData(
        context, widget.privateKey, widget.role.toString().split('.').last);

    // Check if user data is fetched successfully
    if (wasSuccessful) {
      Widget nextScreen = widget.role == Roles.professor
          ? ProfessorMainScreen()
          : StudentMainScreen();

      // Use the custom navigation system to navigate to the next screen
      GuildGameNavigator? navigator = GuildGameNavigator.of(context);
      navigator?.pushScreen(nextScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final questProvider = Provider.of<QuestProvider>(context, listen: true);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);

    var screenSize = MediaQuery.of(context).size; // Get screen size
    var width = screenSize.width / 2;
    var height = screenSize.height / 4;

    if (screenSize.width > screenSize.height) {
      // If landscape
      width = screenSize.width / 4;
      height = screenSize.height / 2;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenSize.height / 20), // Add some space
            const Text(
              'Welcome Young Adventurer to\nThe Uniwa Guild',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ), // Show data
            SizedBox(height: screenSize.height / 20), // Add some space

            Image.asset(
              'assets/images/Guild_logo_TRANS.png',
              width: 200, // specify the desired width
              height: 200, // specify the desired height
            ),
            SizedBox(height: screenSize.height / 20), // Add some space

            const Text(
              'Collecting Necessary Data\nPlease Wait…',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ), // Show data
            SizedBox(height: screenSize.height / 20),
            SizedBox(
              width: width / 3, // Screen width
              height: height / 3, // Screen height
              child: const CircularProgressIndicator(), // Loading animation
            ),
            SizedBox(height: screenSize.height / 20), // Add some space
            const Text('Loading...', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
