import 'package:flutter/material.dart';
import 'package:guild_game_frontend/models/quest.dart';
import 'package:guild_game_frontend/utils/parse_skills.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/action_buttons/complete_quest_button.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/action_buttons/download_pdf_button.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/action_buttons/go_back_button.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/action_buttons/needs_revision_button.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/for_displaying_quest_data/quest_desc.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/for_displaying_quest_data/quest_title.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/for_displaying_quest_data/skills_and_exp_section.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/generic/custom_input_field.dart';

void showQuestManagerModal({
  required BuildContext context,
  required String walletAddress,
  required String questId,
  required Quest quest,
  required String pdfName,
  required Future<void> Function(
          {required String rejectionReason, required String questId})
      needsRevision,
  required Function(String) completeQuest,
}) {
  // final QuestProvider questProvider = QuestProvider();
  final TextEditingController rejectionReasonController =
      TextEditingController();

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
                    exp: quest.xp,
                    skills: skillsToString(quest.requiredSkills),
                  ),
                  // const SizedBox(
                  //   height: 16,
                  // ),
                  QuestDescription(
                      title: 'Description',
                      textAlign: TextAlign.justify,
                      content: quest.desc),
                  CustomInputField(
                      labelTitle: "Rejection Reason\n(In case of revision)",
                      inputPlaceholder: "Enter what the student did wrong...",
                      controller:
                          rejectionReasonController), // Add the description of the quest here

                  const SizedBox(
                    height: 16,
                  ),

                  // Removed the Row for single child
                  ActionsSection(
                    buttons: [
                      DownloadPdfButton(pdfName: pdfName),
                      CompleteQuestButton(
                          onCreate: () => completeQuest(questId)),
                      QuestNeedsRevisiontButton(
                          onCreate: () => needsRevision(
                              rejectionReason: rejectionReasonController.text,
                              questId: questId)),
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
