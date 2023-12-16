import 'package:flutter/material.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color buttonColor;
  final bool isActive;
  double buttonElevation = 10;

  CustomButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.buttonColor = Colors.blue,
      this.isActive = true});

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width / 1.2;
    double buttonHeight = MediaQuery.of(context).size.height / 12;

    if (buttonHeight > 75) buttonHeight = 75;
    if (buttonWidth > 710) buttonWidth = 710;

    return SizedBox(
      height: buttonHeight,
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: buttonElevation,
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: isActive
            ? onPressed
            : () {
                print("Button is inactive");
                showErrorDialog(context, "Please select a user first.");
              },
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
