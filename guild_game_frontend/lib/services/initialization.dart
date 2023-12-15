import 'package:flutter/material.dart';
import 'package:guild_game_frontend/providers/blockchain_provider.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/utils/general.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:guild_game_frontend/widgets/modals/web3_tx_modal.dart';
import 'package:provider/provider.dart';

Future<bool> initializeData(
    BuildContext context, String privateKey, String role) async {
  // Access providers using Provider.of
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final questProvider = Provider.of<QuestProvider>(context, listen: false);
  final blockchainProvider =
      Provider.of<BlockchainProvider>(context, listen: false);

  // Set user wallet in the UserProvider
  final wallet = userProvider.setUserWallet(privateKey);

  try {
    await userProvider
        .fetchUserData(wallet.address.hex)
        .timeout(const Duration(seconds: 5));
    await questProvider.fetchQuests().timeout(const Duration(seconds: 5));
    await blockchainProvider.getUserData();
    return true;
  } catch (error) {
    if (error.toString().contains('User not found')) {
      final String name = randomName(role);
      await userProvider
          .createUser(
              userProvider.pubAddress!, role.toString().split('.').last, name)
          .timeout(const Duration(seconds: 5));
          
      await questProvider.fetchQuests().timeout(const Duration(seconds: 5));

      // Show transaction dialog
      showWaitForTransactionDialog(
        content: "A Transaction is being sent for the creation of a new user.",
        title: "Creating User",
        context: context,
      );

      // Call createUser method of BlockchainProvider
      await blockchainProvider.createUser(name, role, <String>[]);

      Navigator.of(context).pop(); // Close the dialog
      return true;
    } else {
      showErrorDialog(context,
          "Something went wrong with the Server. Please try again later.");
      return false;
    }
  }
}
