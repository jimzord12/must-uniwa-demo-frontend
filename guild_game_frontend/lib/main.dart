import 'package:flutter/material.dart';
import 'package:guild_game_frontend/models/roles.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/screens/loading_screen.dart';
// import 'package:guild_game_frontend/screens/tests/test_my_app.dart';
import 'package:provider/provider.dart';

void main() {
  // Coming from Maria's App

  // Account #01 - Professor
  const String role = 'professor';
  const String privKey =
      "2e0a0ee77631554530414c4a68385fd8328c837a1d5986f1e409f42d58a1a2f1";

  // Account #02 - Student
  // const String role = 'student';
  // const String privKey =
  //     "9ca15b4b9dd7edebefa71fc3bc4c2ec3bde908a9de3bf057495b0c0ceffda798";

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => QuestProvider()),
      ],
      child: MaterialApp(
        home: LoadingScreen(
            privateKey: privKey, role: RoleExtension.fromValue(role)),
        themeMode: ThemeMode.dark, // Use dark theme
        darkTheme: ThemeData(
          // Define dark theme
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
      ),
    ),
  );
}
