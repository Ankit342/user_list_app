import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserProvider with ChangeNotifier {
  List<User> _allUsers = []; // Store all users here.
  List<User> _filteredUsers = []; // Users filtered by search.
  bool _isLoading = false;
  String _errorMessage = '';

  List<User> get users => _filteredUsers.isEmpty ? _allUsers : _filteredUsers;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _allUsers = await ApiService.fetchUsers();
      _filteredUsers = _allUsers; // Initially, show all users.
    } catch (error) {
      _errorMessage = error.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Search users by name
  void searchUsers(String query) {
    if (query.isEmpty) {
      _filteredUsers = _allUsers; // If query is empty, show all users.
    } else {
      _filteredUsers = _allUsers
          .where(
              (user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notify UI to update the list.
  }
}
