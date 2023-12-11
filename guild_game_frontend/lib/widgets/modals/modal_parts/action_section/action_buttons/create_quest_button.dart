import 'package:flutter/material.dart';
import 'package:guild_game_frontend/models/quest.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/utils/parse_skills.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section_button.dart';

class CreateQuestButton extends StatelessWidget {
  final QuestProvider questProvider = QuestProvider();
  final String title;
  final String desc;
  final String requiredSkills;
  final String xp;
  final String createdBy;

  CreateQuestButton({
    super.key,
    required this.title,
    required this.desc,
    required this.requiredSkills,
    required this.xp,
    required this.createdBy,
  });

  @override
  Widget build(BuildContext context) {
    return ActionSectionButton(
        text: "Create Quest", icon: Icons.add, onPressed: _handleQuestCreation);
  }

  void _handleQuestCreation() {
    Quest quest = Quest.newQuest(
        title: title,
        desc: desc,
        requiredSkills: parseSkills(requiredSkills),
        xp: int.parse(xp),
        createdBy: createdBy);

    questProvider.createQuest(quest);
  }
}
