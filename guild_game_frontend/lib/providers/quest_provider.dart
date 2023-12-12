import 'package:flutter/foundation.dart';

import "../models/quest.dart";
import "../services/quest_services.dart";

class QuestProvider with ChangeNotifier {
  List<Quest>? quests;

  Quest? currentQuest = Quest(
    id: "65770ff81469aa1b6a6e37c9",
    questId: 1,
    xp: 555513,
    desc:
        "In the ancient and mystical land of Eldoria, a legendary quest awaits the bravest of souls. Known as \"The Quest for the Celestial Crystal,\" it is a journey fraught with peril, mystery, and the promise of eternal glory. The crystal, believed to be a shard of the fallen star of Eldar, holds immense power and is said to grant its possessor untold strength and wisdom. It lies hidden in the treacherous depths of the Dark Forest, guarded by the enigmatic Forest Spirit—a creature of both beauty and terror, whose riddles have baffled many a brave heart. Along the way, adventurers must traverse through the treacherous paths of the Whispering Woods, cross the tumultuous waters of the River of Sorrow, and face the trials set by the ancient Order of the Starlit Knights, who test the purity of one's heart and the strength of one's resolve. Only those of true valor and noble spirit can hope to claim the Celestial Crystal and emerge as legends in the annals of Eldoria. The quest is a beacon for heroes far and wide, calling to those who dare to dream and are bold enough to embark on a journey that promises to be as rewarding as it is dangerous.",
    title: "Title: Testing Provider",
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
