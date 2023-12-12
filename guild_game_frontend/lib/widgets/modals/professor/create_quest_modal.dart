import 'package:flutter/material.dart';
import 'package:guild_game_frontend/models/quest.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/utils/parse_skills.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/action_buttons/create_quest_button.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/action_buttons/go_back_button.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/action_section/templates/action_section.dart';
import 'package:guild_game_frontend/widgets/modals/modal_parts/generic/custom_input_field.dart';
import 'package:guild_game_frontend/widgets/modals/success_modal.dart';

void showCreateQuestModal(BuildContext context, String walletAddress) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController expController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final QuestProvider questProvider = QuestProvider();

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
                    child: const Text(
                      'Quest Creation',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: CustomInputField(
                      controller: titleController,
                      labelTitle: "Title",
                      inputPlaceholder: "Enter Quest Title",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: CustomInputField(
                      controller: skillsController,
                      labelTitle: "Skills Required",
                      inputPlaceholder:
                          "Enter in this format: Skill1, Skill2, Skill3, ...",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: CustomInputField(
                      controller: expController,
                      labelTitle: "EXP Reward",
                      inputPlaceholder: "Enter Quest's EXP Reward. E.g. 350",
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  Container(
                    alignment: Alignment.center,
                    child: CustomInputField(
                      controller: descController,
                      labelTitle: "Description",
                      inputPlaceholder: "Explain what the Student must do",
                    ),
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  // Removed the Row for single child
                  ActionsSection(
                    buttons: [
                      CreateQuestButton(onCreate: () async {
                        // This is where you handle the quest creation with the current values from the controllers
                        String title = titleController.text;
                        String requiredSkills = skillsController.text;
                        String xp = expController.text;
                        String desc = descController.text;
                        String createdBy = walletAddress;

                        try {
                          print('-  XP: $xp');
                          print('- skills: $requiredSkills');
                          print('- createdBy: $createdBy');
                          print('- title: $title');
                          print('- desc: $desc');

                          int xpValue = int.parse(xp);

                          Quest quest = Quest.newQuest(
                              title: title,
                              desc: desc,
                              requiredSkills: parseSkills(requiredSkills),
                              xp: xpValue,
                              createdBy: createdBy);

                          await questProvider.createQuest(quest);
                          // if (ModalRoute.of(context)?.isCurrent ?? false) {
                            showSuccessDialog(
                                context, "Quest created successfully!");
                            // Navigator.of(context).pop(); // Close current modal
                          // }
                        } on FormatException catch (e) {
                          print('Error parsing XP: ${e.message} | $xp');
                          // Handle the error, such as showing a user-friendly error message
                        } on Exception catch (e) {
                          print('Error creating quest: ${e.toString()}');
                          showErrorDialog(context, e.toString());
                          // Handle the error, such as showing a user-friendly error message
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
