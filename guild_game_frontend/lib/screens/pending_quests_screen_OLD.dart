import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/widgets/modals/professor/manage_submitted_quest_modal.dart';
import 'package:guild_game_frontend/widgets/modals/student/view_completed_quest_modal.dart';
import 'package:guild_game_frontend/widgets/stayros130/custom_button.dart';
import 'package:provider/provider.dart';

class PendingQuestsScreen extends StatelessWidget {
  const PendingQuestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);

    final List<dynamic> quests = userProvider.user!.ongoingQuests;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Quests'),
      ),
      body: SingleChildScrollView(
        // Wrap the Column in a SingleChildScrollView
        child: Center(
          child: Padding(
            // Wrap the Column in a Padding widget
            padding: const EdgeInsets.all(8.0), // Add padding here
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: quests.isEmpty
                  ? [
            SizedBox(height: screenHeight/3),
            const Text('You have do not have any quests pending',
              style: TextStyle(
                fontSize: 21,
                color: Color.fromARGB(127, 255, 255, 255),
                fontWeight: FontWeight.w400,
                ),
              textAlign: TextAlign.center,
              )
            ] :
                  userProvider.user!.pendingReviewQuests.map<Widget>((quest) {
                return CustomButton(
                    buttonText: quest.title,
                    onPressed: () {
                      if (userProvider.user!.role == 'student') {
                        showQuestDetailsModal(
                            context: context,
                            walletAddress: userProvider.pubAddress!,
                            questId: quest.id,
                            quest: quest);
                      } else {
                        showQuestManagerModal(
                            context: context,
                            walletAddress: userProvider.pubAddress!,
                            questId: quest.id,
                            quest: quest,
                            pdfName: quest.pdfFilename);
                      }
                    });
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
