import 'package:flutter/material.dart';

class GuildGameNavigator extends InheritedWidget {
  final Function(Widget) pushScreen;
  final VoidCallback popScreen;

  const GuildGameNavigator({
    super.key,
    required this.pushScreen,
    required this.popScreen,
    required super.child,
  });

  static GuildGameNavigator? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GuildGameNavigator>();
  }

  @override
  bool updateShouldNotify(GuildGameNavigator oldWidget) {
    return pushScreen != oldWidget.pushScreen ||
        popScreen != oldWidget.popScreen;
  }
}
