import 'package:flutter/material.dart';
import 'package:guild_game_frontend/models/quest.dart';
import 'package:guild_game_frontend/services/blockchain_services.dart';

class BlockchainProvider with ChangeNotifier {
  late BlockchainService _blockchainService;

  late int questCompleteAmount;
  late List<String> aquiredSkills;
  late int totalXp;
  late List<Quest> completedQuests;

  // Constructor
  BlockchainProvider(
      {required rpcUrl, required String privateKey, required int chainId}) {
    _blockchainService = BlockchainService(rpcUrl, privateKey, chainId);
  }

  // Example method to call a smart contract function
  Future<void> createUser(String name, String role, List<String> skills) async {
    try {
      await _blockchainService.createUser(
          name: name, role: role, skills: skills);
      // Notify listeners if necessary or handle state updates
      notifyListeners();
    } catch (e) {
      // Handle or throw exception
      print("Error in createUser: $e");
    }
  }

  // Implementing addQuestToUser
  Future<void> addQuestToUser(String questId) async {
    try {
      await _blockchainService.addQuestToUser(questId);
      // Notify listeners or update state as needed
      notifyListeners();
    } catch (e) {
      print("Error in addQuestToUser: $e");
      // Handle exception or notify UI
    }
  }

  // Implementing getUserData
  Future<void> getUserData() async {
    try {
      List<dynamic> userData = await _blockchainService.getUserData();

      if (userData[0] == '') {
        print("From BLockchain Provider: User not found");
        return;
      }

      questCompleteAmount = userData[4];
      aquiredSkills = userData[6];
      totalXp = userData[3];
      completedQuests = userData[2];

      print("From BLockchain Provider: Quest Amount: $questCompleteAmount");
      print("From BLockchain Provider: Skills: $aquiredSkills");
      print("From BLockchain Provider: Total XP: $totalXp");
      print("From BLockchain Provider: Completed Quests: $completedQuests");

      notifyListeners();
    } catch (e) {
      print("Error in getUserData: $e");
    }
  }

  // Implementing getUserQuests
  Future<void> getUserQuests() async {
    try {
      List<dynamic> userQuests = await _blockchainService.getUserQuests();
      // completedQuests = userQuests; //TODO: Fix this

      notifyListeners();

      // Manage the returned data or update UI state as needed
    } catch (e) {
      print("Error in getUserQuests: $e");
    }
  }

  // Implementing createQuest
  Future<void> createQuest(String title, int xp, List<String> skills) async {
    try {
      await _blockchainService.createQuest(title, xp, skills);
      // Notify listeners or update state as needed
      notifyListeners();
    } catch (e) {
      print("Error in createQuest: $e");
      // Handle exception or notify UI
    }
  }

  // Additional methods to interact with other smart contract functions

  // Getter to expose any necessary data
  // String get someData => _blockchainService.someData;
}
