import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';

class ApiService {
  final String apiUrl = 'http://localhost:8080/frontend'; // Ersetzen Sie dies durch Ihre API-URL

  Future<bool> register(UserProfile user) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as bool;
      } else {
        print('Failed to register: ${response.statusCode} ${response.reasonPhrase}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Failed to register: $e');
      return false;
    }
  }
}