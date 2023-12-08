import 'package:flutter/foundation.dart';

import "../models/user.dart";
import "../services/user_services.dart";

class UserProvider with ChangeNotifier {
  User? user;

  Future<void> fetchUserData(String userId) async {
    user = await UserService().fetchUserData(userId);
    notifyListeners();
    // ... handle loading state
  }
  // ... other methods
}
