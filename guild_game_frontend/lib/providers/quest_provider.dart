import 'package:flutter/foundation.dart';

import "../models/quest.dart";
import "../services/quest_services.dart";

class QuestProvider with ChangeNotifier {
  List<Quest>? quests;

  Future<void> fetchQuests() async {
    quests = await QuestService().fetchQuests();
    notifyListeners();
    // ... handle loading state
  }
  // ... other methods
}
