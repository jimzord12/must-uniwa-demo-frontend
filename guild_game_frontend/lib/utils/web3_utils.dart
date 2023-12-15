import 'package:guild_game_frontend/configs/blockchain_config.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

Credentials createWallet(String privateKey) {
  // Creating an Ethereum wallet based on the private key
  final wallet = EthPrivateKey.fromHex(privateKey);
  final address = wallet.address;

  print('Address: ${address.hex}');
  print('Private Key: ${wallet.privateKey}');

  return wallet;
}

Web3Client createWeb3Client() {
  var httpClient = Client();
  final ethClient = Web3Client(BlockchainConfig.rpcUrl, httpClient);
  return ethClient;
}
