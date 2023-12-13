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

Web3Client createWeb3Client(String rpcUrl) {
  var httpClient = Client();
  final ethClient = Web3Client(rpcUrl, httpClient);
  return ethClient;
}

