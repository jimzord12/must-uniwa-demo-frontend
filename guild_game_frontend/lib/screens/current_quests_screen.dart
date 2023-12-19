import 'package:flutter/material.dart';
import 'package:guild_game_frontend/navigation/go_back_button.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/utils/pdf_picker.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:guild_game_frontend/widgets/modals/professor/delete_quest_modal.dart';
import 'package:guild_game_frontend/widgets/modals/student/submit_or_forfeit_quest_modal.dart';
import 'package:guild_game_frontend/widgets/modals/success_modal.dart';
import 'package:guild_game_frontend/widgets/modals/web3_tx_modal.dart';
import 'package:guild_game_frontend/widgets/stayros130/custom_button.dart';
import 'package:provider/provider.dart';

class CurrentQuestsScreen extends StatelessWidget {
  const CurrentQuestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    final QuestProvider questProvider =
        Provider.of<QuestProvider>(context, listen: true);

    final String userRole = userProvider.user!.role;
    final List<dynamic> quests = userProvider.user!.ongoingQuests;

    double screenHeight = MediaQuery.of(context).size.height;

    Future<void> deleteQuest(String questId) async {
      final String address = userProvider.pubAddress!;

      try {
        await questProvider.deleteQuest(address, questId);
        await userProvider.fetchUserData(address);
        // if (ModalRoute.of(context)?.isCurrent ?? false) {
        showSuccessDialog(context, "You have successfully deleted the quest!");
        // Navigator.of(context).pop(); // Close current modal
        // }
      } catch (e) {
        print('Failed to delete quest: $e');
        showErrorDialog(context, "Failed to delete quest. Please try again.");
        // Optionally, show an error dialog or snackbar
      }
    }

    Future<bool> uploadFileHandler(String questId) async {
      final String address = userProvider.pubAddress!;

      try {
        showWaitForTransactionDialog(
            context: context,
            title: "Uploading PDF File",
            content: "Please wait while your PDF File is being uploaded.");
        final Map<String, String>? result =
            await uploadFile(context, address, questId);

        print("******* Upload File Result: $result");

        if (result == null) {
          Navigator.of(context).pop(); // Close the dialog
          throw Exception("Failed to upload file");
        }

        await questProvider.submitQuest(
            result['fileName']!, result['base64String']!, address, questId);

        await userProvider.fetchUserData(address);

        showSuccessDialog(context, "Your PDF Files was uploaded successfully!");
        return true;
        // Simulating successful file upload
      } catch (e) {
        // Handle the error
        showErrorDialog(context, e.toString());
        return false;
      }
    }

    Future<void> forfeitQuest(String questId) async {
      final String address = userProvider.pubAddress!;

      try {
        await questProvider.forfeitQuest(address, questId);
        await userProvider.fetchUserData(address);

        // if (ModalRoute.of(context)?.isCurrent ?? false) {
        showSuccessDialog(context, "The Quest was successfully forfeited.");
        // Navigator.of(context).pop(); // Close current modal
        // }
      } catch (e) {
        print('Failed to retry quest: $e');
        showErrorDialog(context, "Failed to forfeit quest. Please try again.");
        // Optionally, show an error dialog or snackbar
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    48), // Adjust padding to prevent overlap
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (quests.isEmpty) SizedBox(height: screenHeight / 3),
                    if (quests.isEmpty)
                      const Text(
                        'You have not accepted any quests',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(125, 228, 220, 220),
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ...quests.map<Widget>((quest) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: CustomButton(
                          buttonText: quest.title,
                          onPressed: () {
                            if (userRole == 'student') {
                              showSubmitOrForfeitQuestModal(
                                uploadFileHandler: uploadFileHandler,
                                forfeitQuest: forfeitQuest,
                                context: context,
                                walletAddress: userProvider.pubAddress!,
                                questId: quest.id!,
                                quest: quest,
                              );
                            } else {
                              showDeleteQuestModal(
                                context: context,
                                walletAddress: userProvider.pubAddress!,
                                questId: quest.id!,
                                quest: quest,
                                deleteQuest: deleteQuest,
                              );
                            }
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context)
                .padding
                .top, // Align with top of screen, accounting for status bar
            left: 0,
            child: SafeArea(
              child: CustomGoBackButton(
                icon: Icons.arrow_back,
                iconColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
