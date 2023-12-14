import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

Future<bool> initializeData(
    BuildContext context, privateKey, String role) async {
// Access providers using Provider.of
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final questProvider = Provider.of<QuestProvider>(context, listen: false);

  final Credentials wallet = userProvider.setUserWallet(privateKey);

  try {
    await userProvider
        .fetchUserData(wallet.address.hex)
        .timeout(const Duration(seconds: 5));

    await questProvider.fetchQuests().timeout(const Duration(seconds: 5));
    
    return true;
  } catch (error) {
    if (error.toString().contains('User not found')) {
      print(" --> The User was not found. Creating a new one!!!.");
      await userProvider
          .createUser(wallet.address.hex, role.toString().split('.').last)
          .timeout(const Duration(seconds: 5));
      await questProvider.fetchQuests().timeout(const Duration(seconds: 5));
      return true;
    } else {
      print("THE ERROR: $error");
      // General error handling
      showErrorDialog(context,
          "Something went wrong with the Server. Please try again later.");
      return false;
    }
  }
}
