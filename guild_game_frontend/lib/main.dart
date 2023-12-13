import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/screens/loading_screen.dart';
// import 'package:guild_game_frontend/screens/tests/test_my_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => QuestProvider()),
      ],
      child: MaterialApp(
        home: const LoadingScreen(),
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
