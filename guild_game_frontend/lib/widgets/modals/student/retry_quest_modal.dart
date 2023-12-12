import 'package:flutter/material.dart';
import 'package:guild_game_frontend/models/quest.dart';
import 'package:guild_game_frontend/utils/parse_skills.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/action_buttons/go_back_button.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/action_buttons/retry_button.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/for_displaying_quest_data/quest_desc.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/for_displaying_quest_data/quest_title.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/for_displaying_quest_data/skills_and_exp_section.dart';

void showRetryQuestModal(
    BuildContext context, String walletAddress, String questId, Quest quest) {
  showModalBottomSheet(
    context: context,
    isScrollControlled:
        true, // Allows the modal to take up more than half the screen
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.9,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[900], // Dark backdrop as per your description
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            padding: const EdgeInsets.all(32),
            child: SingleChildScrollView(
              // Make the content scrollable
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: QuestTitle(
                        title: 'Quest Title',
                        content: quest.title,
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  SkillsAndEXP(
                      exp: 420, skills: skillsToString(quest.requiredSkills)),
                  const SizedBox(
                    height: 16,
                  ),
                  QuestDescription(
                      title: 'Description',
                      textAlign: TextAlign.justify,
                      content: quest.desc),
                  const SizedBox(
                    height: 24,
                  ),

                  // Removed the Row for single child
                  ActionsSection(
                    buttons: [
                      RetryQuestButton(
                          walletAddress: walletAddress, questId: questId),
                      const GoBackButton(),
                      // Add more buttons as needed
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
