import 'package:flutter/material.dart';
import 'package:guild_game_frontend/models/roles.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/screens/professor_main_screen.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  final String privateKey;
  final Roles role;

  const LoadingScreen(
      {super.key, required this.privateKey, required this.role});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Widget Function(BuildContext) mainScreenBuilder;

  @override
  void initState() {
    super.initState();
    // initializeUserData();
  }

  // Future<void> initializeUserData() async {
  //   final wasSuccessful = await initializeData(
  //       context, widget.privateKey, widget.role.toString().split('.').last);

  //   // Check if user data is fetched successfully
  //   if (wasSuccessful) {
  //     setState(() {
  //       mainScreenBuilder = widget.role == Roles.professor
  //           ? (context) => ProfessorMainScreen()
  //           : (context) => StudentMainScreen();
  //     });

  //     // Navigate to the mainScreen
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: mainScreenBuilder),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final questProvider = Provider.of<QuestProvider>(context, listen: true);
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfessorMainScreen()),
    );

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

// ----------------- Image Part -----------------

            Image.asset(
              'assets/images/Guild_logo_TRANS.png',
              width: 200, // specify the desired width
              height: 200, // specify the desired height
            ),
            SizedBox(height: screenSize.height / 20), // Add some space

// ----------------- Image Part -----------------

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

// class LoadingScreen extends StatelessWidget {
//   final QuestProvider questProvider = QuestProvider();
//   final UserProvider userProvider = UserProvider();

//   final String privateKey;
//   final Roles role;

//   LoadingScreen({super.key, required this.privateKey, required this.role});

//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size; // Get screen size
//     Widget? mainScreen; // Set Student main screen
//     var width = screenSize.width / 2;
//     var height = screenSize.height / 4;
//     // bool isLoading = true; // Set loading state
//     // String role = 'Student'; // Set Student role
//     // String role = 'Professor'; // Set Professor role

//     // Simulate loading
//     // Future.delayed(const Duration(seconds: 3), () {
//     //   isLoading = false;
//     //   if (role == 'Professor')
//     //     mainScreen = ProfessorMainScreen(); // Set Professor main screen

//     //   Navigator.pushReplacement(
//     //     context,
//     //     MaterialPageRoute(builder: (context) => mainScreen),
//     //   );
//     // });

//     // 💎 Initialize your provider's data here
//     (() async {
//       // final Credentials wallet = userProvider.setUserWallet(privateKey);
//       final wasSuccessful = await initializeData(
//           context, privateKey, role.toString().split('.').last);

//       // Check if user data is fetched successfully
//       if (wasSuccessful && userProvider.user != null) {
//         // Decide which mainScreen to use based on the user's role
//         if (userProvider.user!.role == 'professor') {
//           mainScreen = ProfessorMainScreen();
//         } else {
//           mainScreen = StudentMainScreen();
//         }

//         // Navigate to the mainScreen
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => mainScreen!),
//         );
//       }
//     })();

//     if (screenSize.width > screenSize.height) {
//       // If landscape
//       width = screenSize.width / 4;
//       height = screenSize.height / 2;
//     }

//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: screenSize.height / 20), // Add some space
//             const Text(
//               'Welcome Young Adventurer to\nThe Uniwa Guild',
//               style: TextStyle(fontSize: 24),
//               textAlign: TextAlign.center,
//             ), // Show data
//             SizedBox(height: screenSize.height / 20), // Add some space

// // ----------------- Image Part -----------------

//             Image.asset(
//               'assets/images/Guild_logo_TRANS.png',
//               width: 200, // specify the desired width
//               height: 200, // specify the desired height
//             ),
//             SizedBox(height: screenSize.height / 20), // Add some space

// // ----------------- Image Part -----------------

//             const Text(
//               'Collecting Necessary Data\nPlease Wait…',
//               style: TextStyle(fontSize: 24),
//               textAlign: TextAlign.center,
//             ), // Show data
//             SizedBox(height: screenSize.height / 20),
//             SizedBox(
//               width: width / 3, // Screen width
//               height: height / 3, // Screen height
//               child: const CircularProgressIndicator(), // Loading animation
//             ),
//             SizedBox(height: screenSize.height / 20), // Add some space
//             const Text('Loading...', style: TextStyle(fontSize: 18)),
//           ],
//         ),
//       ),
//     );
//   }
// }

/////////////////////////////////////////////////////////////////