import 'package:flutter/foundation.dart';

import "../models/quest.dart";
import "../services/quest_services.dart";

class QuestProvider with ChangeNotifier {
  List<Quest>? quests;

  final QuestService _questService = QuestService();

  Future<void> fetchQuests() async {
    quests = await _questService.fetchAllAvailableQuests();
    notifyListeners();
    // ... handle loading state
  }

  Future<void> createQuest(Quest quest) async {
    await _questService.createQuest(quest);
    await fetchQuests(); // Refresh the quests list
  }

  Future<void> acceptQuest(String walletAddress, int questId) async {
    await _questService.acceptQuest(walletAddress, questId);
    await fetchQuests(); // Refresh the quests list
  }

  Future<void> submitQuest(String pdfName, String pdfString,
      String walletAddress, int questId) async {
    await _questService.sumbitQuest(pdfName, pdfString, walletAddress, questId);
    await fetchQuests(); // Refresh the quests list
  }

  Future<void> forfeitQuest(String walletAddress, int questId) async {
    await _questService.forfeitQuest(walletAddress, questId);
    await fetchQuests(); // Refresh the quests list
  }

  Future<void> retryQuest(String walletAddress, int questId) async {
    await _questService.retryQuest(walletAddress, questId);
    await fetchQuests(); // Refresh the quests list
  }

  Future<void> completeQuest(String walletAddress, int questId) async {
    await _questService.completeQuest(walletAddress, questId);
    await fetchQuests(); // Refresh the quests list
  }

  Future<void> needsRevision(
      String rejectionReason, String walletAddress, int questId) async {
    await _questService.needsRevision(rejectionReason, walletAddress, questId);
    await fetchQuests(); // Refresh the quests list
  }

  Future<void> deleteQuest(String walletAddress, int questId) async {
    await _questService.deleteQuest(walletAddress, questId);
    await fetchQuests(); // Refresh the quests list
  }

  // ... other methods
}
