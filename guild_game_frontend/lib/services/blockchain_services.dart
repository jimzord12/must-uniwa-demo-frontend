import 'package:guild_game_frontend/configs/blockchain_config.dart';
import 'package:guild_game_frontend/models/web3/quest_contract.g.dart';
import 'package:guild_game_frontend/models/web3/user_contract.g.dart';
import 'package:guild_game_frontend/utils/general.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class BlockchainService {
  late Web3Client _web3client;
  late Credentials _wallet;
  late EthereumAddress _userAddress;
  late User_contract _userContract;
  late Quest_contract _questContract;
  final int _chainId;

  BlockchainService(String rpcUrl, String privateKey, this._chainId) {
    _initializeWeb3Client(rpcUrl);
    _setUserWallet(privateKey);
    _userContract = User_contract(
        address: EthereumAddress.fromHex(BlockchainConfig.userContractAddress),
        client: _web3client);
    _questContract = Quest_contract(
        address: EthereumAddress.fromHex(BlockchainConfig.questContractAddress),
        client: _web3client);
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

  Future<void> createQuest(String title, int xp, List<String> skills) async {
    final function = _userContract.self.function('createQuest');
    final params = [title, BigInt.from(xp), skills];

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

  Future<void> addQuestToUser(
      EthereumAddress studentAddress, BigInt questId) async {
    final function = _userContract.self.function('addQuestToUser');
    final params = [studentAddress, questId];

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

  Future<List<dynamic>> getQuestData(int questId) async {
    final function = _questContract.self.function('getQuest');
    final params = [BigInt.from(questId)];

    return await _web3client.call(
      contract: _questContract.self,
      function: function,
      params: params,
    );
  }

  // Additional methods for other smart contract functions
}
