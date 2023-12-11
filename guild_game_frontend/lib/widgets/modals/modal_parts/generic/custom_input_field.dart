import 'package:flutter/material.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/generic/custom_label.dart';

class CustomInputField extends StatefulWidget {
  final String labelTitle;
  final String inputPlaceholder;
  final TextEditingController controller;

  const CustomInputField({
    super.key,
    required this.labelTitle,
    required this.inputPlaceholder,
    required this.controller,
  });

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomLabel(title: widget.labelTitle, content: ""),
          TextField(
            controller: widget.controller, // Use the provided controller
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: widget.inputPlaceholder,
              hintStyle: TextStyle(color: Colors.grey.shade600),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
