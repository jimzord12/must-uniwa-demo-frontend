import 'package:flutter/foundation.dart';

import "../models/user.dart";
import "../services/user_services.dart";

class UserProvider with ChangeNotifier {
  User? user;
  bool isLoading = true; // Loading state flag
  final UserService _userService = UserService();

  Future<void> fetchUserData(String userId) async {
    isLoading = true;
    try {
      user = await _userService.fetchUserData(userId);
      print("SUCCESS - Created the user: $userId");
    } catch (error) {
      print("An error occured while fetchUserData: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
    // ... handle loading state
  }

  Future<void> createUser(String address, String role) async {
    isLoading = true;
    try {
      user = await _userService.createUser(address, role);
      print("SUCCESS - Created the user: $address");
      // ... handle success
    } catch (error) {
      print("An error occured while creating the user: $error");
      // ... handle error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ... other methods, if any
}
