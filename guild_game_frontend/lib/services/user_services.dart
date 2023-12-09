import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserService {
  static const String baseURILocal = "http://10.0.2.2:3000/";
  static const String baseURIWeb =
      "https://must-uniwa-game-server.onrender.com/";

  Future<User> fetchUserData(String walletAddress) async {
    final url = Uri.parse('${baseURILocal}api/user/$walletAddress');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception('Failed to fetch user data: ${response.body}');
    }
  }

// >> Add the WalletAddress as the userId so that I do not have to change a lot of staff in the backend

  Future<User> createUser(String address, String role) async {
    final url = Uri.parse('${baseURILocal}api/user/create');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': address,
        'name': _randomName(role),
        'address': address,
        'role': role,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception('User already exists or duplicate key error');
    } else {
      throw Exception('Failed to create user: ${response.body}');
    }
  }

  String _randomName(String role) {
    final random = Random();
    final randomNumber =
        random.nextInt(99999); // Generates a random number up to 99999
    return '${role}_$randomNumber';
  }

  // ... other methods
}
