import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class ApiService {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/users';

  static Future<List<User>> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((user) => User.fromJson(user)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      throw Exception('Error fetching users: $e');
    }
  }
}
