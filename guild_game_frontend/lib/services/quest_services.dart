import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import "../models/quest.dart";

class QuestService {
  static const String baseURILocalAndroid = "http://10.0.2.2:3000/";
  static const String baseURILocalWindows = "http://localhost:3000/";
  static const String baseURIWeb =
      "https://must-uniwa-game-server.onrender.com/";

  static String get baseURI {
    if (Platform.isAndroid) {
      return baseURILocalAndroid;
    } else if (Platform.isWindows) {
      return baseURILocalWindows;
    } else {
      // You can add more platform checks if needed
      return baseURIWeb;
    }
  }

  Future<List<Quest>> fetchAllAvailableQuests() async {
    final url = Uri.parse('${baseURI}api/guildboard/quests');
    final response = await http.get(url);
    print("RESPONSE BODY: ${response.body}");

    if (response.statusCode == 200) {
      List<dynamic> questsJson = json.decode(response.body);
      return questsJson.map((json) => Quest.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load quests: ${response.body}');
    }
  }

  Future<Quest> createQuest(Quest quest) async {
    final url = Uri.parse('${baseURI}quests'); // Adjusted endpoint
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(quest.toJson()),
    );

    if (response.statusCode == 201) {
      return Quest.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception('Duplicate questId or title');
    } else {
      throw Exception('Failed to create quest: ${response.body}');
    }
  }

  // If Status: 200 OK, the quest is accepted
  Future<bool> acceptQuest(String walletAddress, String questId) async {
    final url = Uri.parse(
        '${baseURI}api/user/$walletAddress/acceptQuest/$questId'); // Adjusted endpoint
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    print("acceptQuest() - THE RESPONSE IS: ${response.body}");

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      throw Exception('User, Quest, or GuildBoard not found');
    } else if (response.statusCode == 403) {
      throw Exception('Only students can accept quests');
    } else {
      throw Exception('Failed to accept quest: ${response.body}');
    }
  }

  // If Status: 200 OK, the quest is accepted
  Future<bool> sumbitQuest(String pdfName, String pdfString,
      String walletAddress, String questId) async {
    final url =
        Uri.parse('${baseURI}api/user/$walletAddress/submitQuest/$questId');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'pdfName': pdfName, 'pdfString': pdfString}),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      throw Exception('No PDF file uploaded');
    } else if (response.statusCode == 403) {
      throw Exception('Only students can submit quests');
    } else if (response.statusCode == 404) {
      throw Exception('User or Quest not found');
    } else {
      throw Exception('Failed to submit quest: ${response.body}');
    }
  }

  Future<bool> forfeitQuest(String walletAddress, String questId) async {
    final url =
        Uri.parse('${baseURI}api/user/$walletAddress/forfeitQuest/$questId');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw Exception('Only students can forfeit quests');
    } else if (response.statusCode == 404) {
      throw Exception('User, Quest, or GuildBoard not found');
    } else {
      throw Exception('Failed to forfeit quest: ${response.body}');
    }
  }

  Future<bool> retryQuest(String walletAddress, String questId) async {
    final url =
        Uri.parse('${baseURI}api/user/$walletAddress/retryQuest/$questId');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      throw Exception('Quest not found in rejected quests');
    } else if (response.statusCode == 404) {
      throw Exception('User, Quest, Quest Creator not found');
    } else {
      throw Exception('Failed to retry quest: ${response.body}');
    }
  }

  Future<bool> completeQuest(String walletAddress, String questId) async {
    final url =
        Uri.parse('${baseURI}api/user/$walletAddress/completeQuest/$questId');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw Exception('Only professors can complete quests');
    } else if (response.statusCode == 404) {
      throw Exception('User or Quest not found');
    } else {
      throw Exception('Failed to complete quest: ${response.body}');
    }
  }

  Future<bool> needsRevision(
      String rejectionReason, String walletAddress, String questId) async {
    final url = Uri.parse('${baseURI}api/quest/$questId/needsRevision');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'rejection_reason_text': rejectionReason}),
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      throw Exception('Quest not found or no rejection_reason_text');
    } else {
      throw Exception('Failed to mark quest for revision: ${response.body}');
    }
  }

  Future<bool> deleteQuest(String walletAddress, String questId) async {
    final url = Uri.parse(
        '${baseURI}api/professor/$walletAddress/deleteQuest/$questId');
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw Exception('Only professors can delete quests');
    } else if (response.statusCode == 404) {
      throw Exception('Quest not found');
    } else {
      throw Exception('Failed to delete quest: ${response.body}');
    }
  }

  Future<String> fetchPdfContent(String pdfName) async {
    final url = Uri.parse('${baseURI}api/pdf/$pdfName');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> pdfJson = json.decode(response.body);
      return pdfJson['content'];
    } else if (response.statusCode == 404) {
      throw Exception('PDF not found');
    } else {
      throw Exception('Failed to load PDF content: ${response.body}');
    }
  }

  Future<Quest> getQuestById(String questId) async {
    final url = Uri.parse('${baseURI}api/quest/$questId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Assuming the server returns a JSON object that can be parsed into a Quest object
      return Quest.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Quest not found');
    } else {
      throw Exception('Failed to get quest by ID: ${response.body}');
    }
  }

  // ... other methods
}
