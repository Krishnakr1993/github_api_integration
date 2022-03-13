import 'dart:convert';

import 'package:github_api_integration/Models/Repos.dart';

List<Repo> parseAgents(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Repo>((json) => Repo.fromJson(json)).toList();
}
