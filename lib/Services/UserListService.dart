 import 'dart:convert';

import 'package:github_api_integration/Models/Users.dart';
import 'package:github_api_integration/connectivity.dart';
import 'package:http/http.dart' as http;
String url = 'https://api.github.com/users';
  Future<List<User>> getAllulistList() async {
     checkConnectivity1();
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print(response.body);
        List<User> list = parseAgents(response.body);
        return list;
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

   List<User> parseAgents(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }