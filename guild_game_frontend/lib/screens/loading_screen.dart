import 'package:flutter/material.dart';
import 'package:micro_guild_game/screens/student_main_screen.dart';
import 'package:micro_guild_game/screens/professor_main_screen.dart';

class LoadingScreen extends StatelessWidget {
 const LoadingScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size; // Get screen size
    bool isLoading = true; // Set loading state
    var width = screenSize.width/2;
    var height = screenSize.height/4;
    // String role = 'Student'; // Set Student role
    String role = 'Professor'; // Set Professor role
    Widget mainScreen = StudentMainScreen(); // Set Student main screen
    
    // Simulate loading 
    Future.delayed(const Duration(seconds: 3), () {
      isLoading = false;
      if (role == 'Professor') mainScreen = ProfessorMainScreen(); // Set Professor main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => mainScreen),
      );
    });

    if (screenSize.width > screenSize.height) { // If landscape
      width = screenSize.width/4;
      height = screenSize.height/2;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenSize.height/20), // Add some space
            const Text(
              'Welcome Young Adventurer to\nThe Uniwa Guild',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ), // Show data
            SizedBox(height: screenSize.height/20), // Add some space

//----------------- Image Part -----------------

            // Image.asset('lib/assets/images/kitty.png'), // Add image from assets
            // SizedBox(height: screenSize.height/20), // Add some space

//----------------- Image Part -----------------

            const Text(
              'Collecting Necessary Data\nPlease Wait…',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ), // Show data
            SizedBox(height: screenSize.height/20),
            SizedBox(
              width: width, // Screen width
              height: height, // Screen height
              child: const CircularProgressIndicator(), // Loading animation
            ),
            SizedBox(height: screenSize.height/20), // Add some space
            const Text('Loading...', style: TextStyle(fontSize: 18)), 
          ],
        ),
      ),
    );
  }
}