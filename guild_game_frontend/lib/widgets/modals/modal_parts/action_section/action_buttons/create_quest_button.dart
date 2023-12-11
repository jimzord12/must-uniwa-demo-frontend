import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class CreateQuestButton extends StatelessWidget {
  final QuestProvider questProvider = QuestProvider();
  final VoidCallback onCreate; // A callback function for creation

  // final String title;
  // final String desc;
  // final String requiredSkills;
  // final String xp;
  // final String createdBy;

  CreateQuestButton({
    super.key,
    required this.onCreate,
    // required this.title,
    // required this.desc,
    // required this.requiredSkills,
    // required this.xp,
    // required this.createdBy,
  });

  @override
  Widget build(BuildContext context) {
    return ActionSectionButton(
      text: "Create Quest",
      icon: Icons.add,
      onPressed: onCreate,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
}
//   void onCreate(BuildContext context) async {
//     try {
//       print('-  XP: $xp');
//       print('- skills: $requiredSkills');
//       print('- createdBy: $createdBy');
//       print('- title: $title');
//       print('- desc: $desc');

//       int xpValue = int.parse(xp);

//       Quest quest = Quest.newQuest(
//           title: title,
//           desc: desc,
//           requiredSkills: parseSkills(requiredSkills),
//           xp: xpValue,
//           createdBy: createdBy);

//       await questProvider.createQuest(quest);

//       showSuccessDialog(context, "Quest created successfully!");
//     } on FormatException catch (e) {
//       print('Error parsing XP: ${e.message} | $xp');
//       // Handle the error, such as showing a user-friendly error message
//     } on Exception catch (e) {
//       print('Error creating quest: ${e.toString()}');
//       showErrorDialog(context, e.toString());
//       // Handle the error, such as showing a user-friendly error message
//     }
//   }
// }
