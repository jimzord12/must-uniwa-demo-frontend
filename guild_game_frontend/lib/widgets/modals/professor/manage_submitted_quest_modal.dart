import 'package:flutter/material.dart';
import 'package:guild_game_frontend/models/quest.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/utils/parse_skills.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/action_buttons/complete_quest_button.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/action_buttons/download_pdf_button.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/action_buttons/go_back_button.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/action_buttons/needs_revision_button.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/for_displaying_quest_data/quest_desc.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/for_displaying_quest_data/quest_title.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/for_displaying_quest_data/skills_and_exp_section.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/generic/custom_input_field.dart';
import 'package:guild_game_frontend/widgets/modals/success_modal.dart';

void showQuestManagerModal({
  required BuildContext context,
  required String walletAddress,
  required String questId,
  required Quest quest,
  required String pdfName,
}) {
  final QuestProvider questProvider = QuestProvider();
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
                      labelTitle: "Rejection Reason (In case of revision)",
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
                          walletAddress: walletAddress, questId: questId),
                      QuestNeedsRevisiontButton(onCreate: () async {
                        String rejectionReason = rejectionReasonController.text;

                        try {
                          print('-  rejectionReason: $rejectionReason');

                          await questProvider.needsRevision(
                              rejectionReason, walletAddress, questId);
                          // if (ModalRoute.of(context)?.isCurrent ?? false) {
                          showSuccessDialog(context,
                              "The Quest was successfully sent back for revison.");
                          // Navigator.of(context).pop(); // Close current modal
                          // }
                        } catch (e) {
                          print('Failed to retry quest: $e');
                          showErrorDialog(context,
                              "Failed to sent back quest for revision. Rejection Reason is mandatory. Please try again.");
                          // Optionally, show an error dialog or snackbar
                        }
                      }),
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
