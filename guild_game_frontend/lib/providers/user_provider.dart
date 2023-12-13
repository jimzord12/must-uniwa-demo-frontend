import 'package:flutter/foundation.dart';
import "package:guild_game_frontend/models/quest.dart";
import "package:guild_game_frontend/utils/web3_utils.dart";
import "package:web3dart/web3dart.dart";

import "../models/user.dart";
import "../services/user_services.dart";

class UserProvider with ChangeNotifier {
  User? user;
  bool isLoading = true; // Loading state flag
  Credentials? wallet;
  String? pubAddress;

  final UserService _userService = UserService();

  Future<void> fetchUserData(String userId) async {
    isLoading = true;
    try {
      user = await _userService.fetchUserData(userId);
      await getUserQuests(userId);
      print("1. SUCCESS - User Data Fethced: ${user!.userId}");
      print("2. SUCCESS - User Data Fethced: ${user!.role}");
      print("3. SUCCESS - User Data Fethced: ${user!.xp}");
    } catch (error) {
      print("An error occurred while fetchUserData: $error");
      rethrow; // Rethrow the error
    } finally {
      isLoading = false;
      notifyListeners();
    }
    // ... handle loading state
  }

  Future<void> createUser(String address, String role) async {
    isLoading = true;
    try {
      user = await _userService.createUser(address, role);
      print("SUCCESS - Created the user: $address");
      // ... handle success
    } catch (error) {
      print("An error occurred while creating the user: $error");
      rethrow; // Rethrow the error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getUserQuests(String address) async {
    isLoading = true;
    try {
      Map<String, dynamic> quests = await _userService.getUserQuests(address);
      user!.completedQuests = (quests['completedQuests'] as List)
          .map((i) => Quest.fromJson(i))
          .toList();
      user!.ongoingQuests = (quests['ongoingQuests'] as List)
          .map((i) => Quest.fromJson(i))
          .toList();
      user!.pendingReviewQuests = (quests['pendingReviewQuests'] as List)
          .map((i) => Quest.fromJson(i))
          .toList();
      user!.rejectedQuests = (quests['rejectedQuests'] as List)
          .map((i) => Quest.fromJson(i))
          .toList();
      print("SUCCESS - Ongoing Quests: ${user!.ongoingQuests}");
      print("SUCCESS - Completed Quests: ${user!.completedQuests}");
      print("SUCCESS - Pending Quests: ${user!.pendingReviewQuests}");
      print("SUCCESS - Rejected Quests: ${user!.rejectedQuests}");
      // ... handle success
    } catch (error) {
      print("An error occurred while fetchUserData: $error");
      rethrow; // Rethrow the error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Credentials setUserWallet(String privateKey) {
    wallet = createWallet(privateKey);
    pubAddress = wallet!.address.hex;
    print("Wallet address: $pubAddress");
    notifyListeners();
    return wallet!;
  }

  // ... other methods, if any
}
