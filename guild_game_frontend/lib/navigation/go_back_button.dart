import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guild_game_frontend/navigation/custom_navigation.dart';

class CustomGoBackButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color? iconColor;
  final Color? buttonColor;
  final VoidCallback? onPressed;
  final double iconSize;
  final double buttonSize;

  const CustomGoBackButton({
    super.key,
    this.icon = Icons.arrow_back,
    this.iconSize = 24,
    this.buttonSize = 24.0,
    this.tooltip = '',
    this.iconColor,
    this.buttonColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the platform is Android
    bool isAndroid = defaultTargetPlatform == TargetPlatform.android;

    double adjustedIconSize = isAndroid ? iconSize * 0.5 : iconSize;
    double adjustedButtonSize = isAndroid ? buttonSize * 0.5 : buttonSize;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? Colors.amber.shade700,
        shape: const CircleBorder(),
        padding: EdgeInsets.all(adjustedButtonSize / 2),
      ),
      onPressed: onPressed ??
          () {
            GuildGameNavigator? navigator = GuildGameNavigator.of(context);
            navigator?.popScreen();
          },
      child: Icon(
        icon,
        color: iconColor ?? Colors.black,
        size: adjustedIconSize,
      ),
    );
  }
}
