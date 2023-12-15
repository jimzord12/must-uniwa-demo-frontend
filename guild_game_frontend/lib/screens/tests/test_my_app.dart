// import 'package:flutter/material.dart';
// import 'package:guild_game_frontend/providers/quest_provider.dart';
// import 'package:guild_game_frontend/providers/user_provider.dart';
// import 'package:guild_game_frontend/screens/tests/test_my_home_page.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     final UserProvider userProvider = UserProvider();
//     final QuestProvider questProvider = QuestProvider();
//     // bool readyToGo_User = false;
//     // bool readyToGo_Quests = false;
//     // bool readyToGo = readyToGo_User && readyToGo_Quests;

//     Future<void> fetchQuests() async {
//       await questProvider.fetchQuests();
//       // readyToGo_Quests = true;
//     }

//     Future<void> fetchUser() async {
//       await userProvider.fetchUserData("0xStudent___01___");
//       // readyToGo_User = true;
//     }

//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
