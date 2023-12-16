import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/user.dart';

class UserService {
  static const String baseURILocalAndroid = "http://10.0.2.2:3000/";
  static const String baseURILocalWindows = "http://localhost:3000/";
  static const String baseURIWeb =
      "https://must-uniwa-game-server.onrender.com/";

  static const bool production = true;

  static String get baseURI {
    if (production == true) {
      return baseURIWeb;
    }
    if (Platform.isAndroid) {
      return baseURILocalAndroid;
    } else if (Platform.isWindows) {
      return baseURILocalWindows;
    } else {
      // You can add more platform checks if needed
      return baseURIWeb;
    }
  }

  Future<User> fetchUserData(String walletAddress) async {
    final url = Uri.parse('${baseURI}api/user/$walletAddress');
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

  Future<User> createUser(String address, String role, String name) async {
    final url = Uri.parse('${baseURI}api/user/create');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': address,
        'name': name,
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

  Future<Map<String, dynamic>> getUserQuests(String address) async {
    final response =
        await http.get(Uri.parse('${baseURI}api/user/$address/quests'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('User not found. While Getting User\'s Quests');
    } else {
      throw Exception('Failed to get user quests: ${response.body}');
    }
  }

  // ... other methods
}
