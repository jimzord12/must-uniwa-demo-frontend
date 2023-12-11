import 'package:flutter/foundation.dart';

import "../models/quest.dart";
import "../services/quest_services.dart";

class QuestProvider with ChangeNotifier {
  List<Quest>? quests;

  Quest? currentQuest = Quest(
    id: "65770ff81469aa1b6a6e37c9",
    questId: 1,
    xp: 555513,
    desc: "Asdasdasdsad",
    title: "TEST PROVIDER",
    creationDate: DateTime.now(),
    submissionDates: [],
    revisions: 0,
    requiredSkills: ["Farting Hero", "Mind Reading", "Flying"],
    createdBy: "0xProfessor______01______",
    assignedTo: "0xStudent___01___",
    isDone: false,
    pdfFilename: "Answers_Pdf_File_3",
  );

  final QuestService _questService = QuestService();

  Future<void> fetchQuests() async {
    quests = await _questService.fetchAllAvailableQuests();
    print("THE QUESTS ARE: $quests");
    notifyListeners();
    // ... handle loading state
  }

  Future<void> createQuest(Quest quest) async {
    await _questService.createQuest(quest);
    await fetchQuests(); // Refresh the quests list
  }

  Future<void> acceptQuest(String walletAddress, String questId) async {
    await _questService.acceptQuest(walletAddress, questId);
    await fetchQuests(); // Refresh the quests list
  }

  Future<void> submitQuest(String pdfName, String pdfString,
      String walletAddress, String questId) async {
    await _questService.sumbitQuest(pdfName, pdfString, walletAddress, questId);
    await fetchQuests(); // Refresh the quests list
  }

  Future<void> forfeitQuest(String walletAddress, String questId) async {
    await _questService.forfeitQuest(walletAddress, questId);
    await fetchQuests(); // Refresh the quests list
  }

  Future<void> retryQuest(String walletAddress, String questId) async {
    await _questService.retryQuest(walletAddress, questId);
    await fetchQuests(); // Refresh the quests list
  }

  Future<void> completeQuest(String walletAddress, String questId) async {
    await _questService.completeQuest(walletAddress, questId);
    await fetchQuests(); // Refresh the quests list
  }

  Future<void> needsRevision(
      String rejectionReason, String walletAddress, String questId) async {
    await _questService.needsRevision(rejectionReason, walletAddress, questId);
    await fetchQuests(); // Refresh the quests list
  }

  Future<void> deleteQuest(String walletAddress, String questId) async {
    await _questService.deleteQuest(walletAddress, questId);
    await fetchQuests(); // Refresh the quests list
  }

  Future<String> fetchPdfContent(String pdfFileName) async {
    final base64PdfContent = await _questService.fetchPdfContent(pdfFileName);
    await fetchQuests(); // Refresh the quests list
    return base64PdfContent;
  }

  // ... other methods
}
