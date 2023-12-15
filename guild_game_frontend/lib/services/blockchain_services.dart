import 'package:guild_game_frontend/models/web3/user_contract.g.dart';
import 'package:guild_game_frontend/utils/general.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class BlockchainService {
  late Web3Client _web3client;
  late Credentials _wallet;
  late EthereumAddress _userAddress;
  late User_contract _userContract;
  final int _chainId;

  BlockchainService(String rpcUrl, String privateKey, this._chainId) {
    _initializeWeb3Client(rpcUrl);
    _setUserWallet(privateKey);
  }

  void _initializeWeb3Client(String rpcUrl) {
    var httpClient = Client();
    _web3client = Web3Client(rpcUrl, httpClient);
  }

  void _setUserWallet(String privateKey) {
    _wallet = EthPrivateKey.fromHex(privateKey);
    _userAddress = _wallet.address;
  }

  Future<void> createUser(
      {required name,
      required String role,
      required List<String> skills}) async {
    final createUserFunction = _userContract.self.function('createUser');
    final params = [name, convertRoleToNumber(role), skills];

    await _web3client.sendTransaction(
      _wallet,
      Transaction.callContract(
        contract: _userContract.self,
        function: createUserFunction,
        parameters: params,
      ),
      chainId: _chainId,
    );
  }

  Future<void> addQuestToUser(String questId) async {
    final function = _userContract.self.function('addQuestToUser');
    final params = [_userAddress, questId];

    await _web3client.sendTransaction(
      _wallet,
      Transaction.callContract(
        contract: _userContract.self,
        function: function,
        parameters: params,
      ),
      chainId: _chainId,
    );
  }

  Future<List<dynamic>> getUserData() async {
    final function = _userContract.self.function('getUser');
    final params = [_userAddress];

    return await _web3client.call(
      contract: _userContract.self,
      function: function,
      params: params,
    );
  }

  Future<List<dynamic>> getUserQuests() async {
    final function = _userContract.self.function('getUserQuests');
    final params = [_userAddress];

    return await _web3client.call(
      contract: _userContract.self,
      function: function,
      params: params,
    );
  }

  Future<void> createQuest(String title, int xp, List<String> skills) async {
    final function = _userContract.self.function('createQuest');
    final params = [title, xp, skills];

    await _web3client.sendTransaction(
      _wallet,
      Transaction.callContract(
        contract: _userContract.self,
        function: function,
        parameters: params,
      ),
      chainId: _chainId,
    );
  }

  // Additional methods for other smart contract functions
}
