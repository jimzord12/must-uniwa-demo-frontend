import 'package:flutter/material.dart';
import 'package:guild_game_frontend/models/roles.dart';
import 'package:guild_game_frontend/navigation/custom_navigation.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/screens/loading_screen.dart';
import 'package:provider/provider.dart';

class GuildGameModuleWidget extends StatefulWidget {
  final String role;
  final String privKey;

  const GuildGameModuleWidget(
      {Key? key, required this.role, required this.privKey})
      : super(key: key);

  @override
  _GuildGameModuleWidgetState createState() => _GuildGameModuleWidgetState();
}

class _GuildGameModuleWidgetState extends State<GuildGameModuleWidget> {
  final List<Widget> _navigationStack = [];

  @override
  void initState() {
    super.initState();
    // Push the initial screen onto the stack
    pushScreen(LoadingScreen(
        privateKey: widget.privKey,
        role: RoleExtension.fromValue(widget.role)));
  }

  void pushScreen(Widget screen) {
    setState(() {
      _navigationStack.add(screen);
    });
  }

  void popScreen() {
    if (_navigationStack.length > 1) {
      setState(() {
        _navigationStack.removeLast();
      });
    } else {
      // Handle behavior when trying to pop the last screen (e.g., exit the module)
    }
  }

  @override
  Widget build(BuildContext context) {
    return GuildGameNavigator(
      pushScreen: pushScreen,
      popScreen: popScreen,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => QuestProvider()),
        ],
        child: Scaffold(
          body: _navigationStack.last,
        ),
      ),
    );
  }
}
