import 'package:flutter/foundation.dart'; // Import the foundation library for ChangeNotifier
import 'package:flutter/material.dart';

class UserState extends ChangeNotifier { // Extend ChangeNotifier
  late final String userId;

  UserState({required this.userId});

  void updateUserId(String newUserId) {
    userId = newUserId;
    notifyListeners();
  }
}

