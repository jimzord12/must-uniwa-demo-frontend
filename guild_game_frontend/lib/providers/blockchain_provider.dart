import 'package:flutter/material.dart';
import 'package:guild_game_frontend/models/quest.dart';
import 'package:guild_game_frontend/services/blockchain_services.dart';
import 'package:guild_game_frontend/utils/general.dart';

class BlockchainProvider with ChangeNotifier {
  late BlockchainService _blockchainService;

  late int questCompleteAmount;
  late List<String> aquiredSkills;
  late int totalXp;
  late List<int> userQuests;
  late String userRole;
  final List<Quest> completedQuests = [];

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
  Future<void> addQuestToUser(BigInt questId) async {
    try {
      await _blockchainService.addQuestToUser(questId);
      // Notify listeners or update state as needed
      notifyListeners();
    } catch (e) {
      print("Error in addQuestToUser: $e");
      // Handle exception or notify UI
    }
  }

  Future<void> getUserData() async {
    try {
      List<dynamic> outerUserData = await _blockchainService.getUserData();
      await getUserQuests(); // this one populates the completedQuests list

      print("getUserData: ${outerUserData[0]}");

      if (outerUserData[0][0] == '') {
        print(
            "From Blockchain Provider: User not found, ${outerUserData[0][0]}");
        return;
      }

      // Extract the inner array
      List<dynamic> userData = outerUserData[0];

      print("BLOCKCHAIN - TYPES");
      print("");

      print("Type of userData[1]: ${userData[1].runtimeType}");
      print("Type of Quest List userData[2]: ${userData[2].runtimeType}");
      if (userData[2].isNotEmpty) {
        print(
            "Type of Quest Element: userData[2]: ${userData[2][0].runtimeType}");
      }
      print("Type of userData[3]: ${userData[3].runtimeType}");
      print("Type of userData[4]: ${userData[4].runtimeType}");
      print("Type of userData[5]: ${userData[5].runtimeType}");
      if (userData[5].isNotEmpty) {
        print(
            "Type of Skills Element: userData[2]: ${userData[5][0].runtimeType}");
      }

      // convertRoleToString takes a BigInt and returns a 'student' or 'professor
      userRole = convertRoleToString(userData[1] as BigInt);
      // userQuests = userData[2];
      userQuests =
          (userData[2] as List).map((e) => (e as BigInt).toInt()).toList();
      // totalXp = (userData[3] as BigInt).toInt();
      totalXp = (userData[3] as BigInt).toInt();
      // questCompleteAmount = (userData[4] as BigInt).toInt();
      questCompleteAmount = (userData[4] as BigInt).toInt();

      if (userData[5].isEmpty) {
        aquiredSkills = [];
      } else {
        aquiredSkills = List<String>.from(userData[5]);
      }

      // print("From BLockchain Provider: Quest Amount: $questCompleteAmount");
      // print("From BLockchain Provider: Skills: $aquiredSkills");
      // print("From BLockchain Provider: Total XP: $totalXp");
      // print("From BLockchain Provider: Completed Quests: $completedQuests");

      notifyListeners();
    } catch (e) {
      print("Error in getUserData: $e");
    }
  }

  // Implementing getUserQuests
  Future<void> getUserQuests() async {
    try {
      List<dynamic> response = await _blockchainService.getUserQuests();
      print("getUser QUESTS: $response");
      final List<dynamic> userQuestsFromContract = response[0];

      // Convert each BigInt element to int and store it in userQuests
      if (userQuestsFromContract.isEmpty) {
        print("getUser QUESTS:IS EMPTY!");

        return;
      } else {
        print("(NOT EMPTY) getUser QUESTS: $userQuestsFromContract");

        userQuests =
            userQuestsFromContract.map((e) => (e as BigInt).toInt()).toList();

        for (var i = 0; i < userQuests.length; i++) {
          final Quest? quest = await getSpecificQuest(userQuests[i]);
          if (quest != null) {
            completedQuests.add(quest);
          }
        }
      }

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

  Future<Quest?> getSpecificQuest(int questId) async {
    try {
      List<dynamic> response = await _blockchainService.getQuestData(questId);
      List<dynamic> questDataFromCOntract = response[0];

      return Quest.newQuest(
          requiredSkills: List<String>.from(questDataFromCOntract[4]),
          xp: (questDataFromCOntract[3] as BigInt).toInt(),
          desc: "Come From Blockchain",
          title: questDataFromCOntract[0],
          createdBy: questDataFromCOntract[1].hex);
    } catch (e) {
      print("Error in getSpecificQuest: $e");
    }
    return null;
  }

  // Additional methods to interact with other smart contract functions

  // Getter to expose any necessary data
  // String get someData => _blockchainService.someData;
}
