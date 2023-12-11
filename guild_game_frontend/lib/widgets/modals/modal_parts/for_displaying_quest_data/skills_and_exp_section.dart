import 'package:flutter/material.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/generic/custom_label.dart';

class SkillsAndEXP extends StatelessWidget {
  final String skills;
  final int exp;
  final TextAlign textAlign;

  const SkillsAndEXP({
    Key? key,
    required this.skills,
    required this.exp,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Padding inside the container
      margin: const EdgeInsets.symmetric(
          vertical: 4.0), // Space around the container
      decoration: BoxDecoration(
        color: Colors.grey.shade800, // Grey background color
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment
            .start, // Align text to the start of the container
        children: [
          CustomLabel(title: 'Skills', content: skills),
          // const SizedBox(
          //   height: 4,
          // ),
          CustomLabel(title: 'EXP', content: exp.toString()),
        ],
      ),
    );
  }
}
