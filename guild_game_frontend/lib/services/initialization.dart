import 'package:flutter/material.dart';
import 'package:guild_game_frontend/configs/blockchain_config.dart';
import 'package:guild_game_frontend/models/web3/user_contract.g.dart';
import 'package:guild_game_frontend/providers/quest_provider.dart';
import 'package:guild_game_frontend/providers/user_provider.dart';
import 'package:guild_game_frontend/utils/general.dart';
import 'package:guild_game_frontend/utils/web3_utils.dart';
import 'package:guild_game_frontend/widgets/modals/error_modal.dart';
import 'package:guild_game_frontend/widgets/modals/web3_tx_modal.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

Future<bool> initializeData(
    BuildContext context, privateKey, String role) async {
// Access providers using Provider.of
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final questProvider = Provider.of<QuestProvider>(context, listen: false);

// Web3 Staff --- START
  final Credentials wallet = userProvider.setUserWallet(privateKey);

  // final EthereumAddress userAddress = wallet.address;
  final Web3Client web3client = createWeb3Client();

  final User_contract userContract = User_contract(
      address: EthereumAddress.fromHex(BlockchainConfig.userContractAddress),
      client: web3client);

  print('');
  print('------------------------------------------------------------');
  print(" --> Wallet: ${wallet.address.hexEip55}");
  print('');

  print('');
  print('------------------------------------------------------------');
  print(" --> Web3 Client: $web3client}");
  print('');

  print('');
  print('------------------------------------------------------------');
  print(
      " --> User Contract Address: ${EthereumAddress.fromHex(BlockchainConfig.userContractAddress)}");
  print('');

  print('');
  print('------------------------------------------------------------');
  print(" --> User Contract: ${userContract.self}");
  print('');
  // final addQuestToUserFunction = userContract.self.function('addQuestToUser');
  // final params_02 = [userAddress, questId];

  // final getUserDataFunction = userContract.self.function('getUser');
  // final params_03 = [wallet.address.hex, role.toString().split('.').last];

  // final getUserQuestsFunction = userContract.self.function('getUserQuests');
  // final params_04 = [wallet.address.hex, role.toString().split('.').last];

  // final createQuest = userContract.self.function('createQuest');
  // final params_05 = [wallet.address.hex, role.toString().split('.').last];

// Web3 Staff --- END

  try {
    await userProvider
        .fetchUserData(wallet.address.hex)
        .timeout(const Duration(seconds: 5));

    await questProvider.fetchQuests().timeout(const Duration(seconds: 5));

    return true;
  } catch (error) {
    if (error.toString().contains('User not found')) {
      print('');
      print('------------------------------------------------------------');
      print(" --> The User was not found. Creating a new one!!!.");
      print('');

      final String name = randomName(role);
      await userProvider
          .createUser(wallet.address.hex, role.toString().split('.').last, name)
          .timeout(const Duration(seconds: 5));
      await questProvider.fetchQuests().timeout(const Duration(seconds: 5));

      // Web3 -Tx Prep
      final createUserFunction = userContract.self.function('createUser');
      final params_01 = [name, convertRoleToNumber(role), <String>[]];

      showWaitForTransactionDialog(
          content: "A Transaction is been sent for the creation of a new user.",
          title: "Creating User",
          context: context);

      print('');
      print('------------------------------------------------------------');
      print(" --> Blockchain: <Creating a new User>");
      print('');

      // Send the transaction
      await web3client.sendTransaction(
        wallet,
        Transaction.callContract(
          contract: userContract.self,
          function: createUserFunction,
          parameters: params_01,
        ),
      );

      print('');
      print('------------------------------------------------------------');
      print(" --> #### THE Transaction was sent ####.");
      print('');

      Navigator.of(context).pop(); // Close the dialog

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
