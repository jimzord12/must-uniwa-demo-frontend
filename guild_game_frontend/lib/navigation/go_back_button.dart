import 'package:flutter/material.dart';
import 'package:guild_game_frontend/navigation/custom_navigation.dart';

class CustomGoBackButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color? iconColor;
  final Color? buttonColor;
  final VoidCallback? onPressed;

  const CustomGoBackButton({
    super.key,
    required this.icon,
    this.tooltip = '',
    this.iconColor,
    this.buttonColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber.shade700,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(
            36), // Increase the padding value for a bigger button
      ),
      onPressed: onPressed ??
          () {
            // Using custom navigation system to pop the screen
            GuildGameNavigator? navigator = GuildGameNavigator.of(context);
            navigator?.popScreen();
          },
      child: Transform.scale(
        scale: 2, // Increase the scale value for a bigger icon
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}
