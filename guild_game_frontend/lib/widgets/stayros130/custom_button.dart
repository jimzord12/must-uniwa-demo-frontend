import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key,required this.buttonText, required this.onPressed});

  final String buttonText;
  final VoidCallback onPressed;
  Color buttonColor = Colors.blue;
  double buttonElevation = 10;

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
        onPressed: onPressed,
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