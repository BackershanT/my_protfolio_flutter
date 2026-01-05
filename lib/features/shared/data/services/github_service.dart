import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/github_stats_model.dart';

class GithubService {
  static const String _baseUrl = 'https://api.github.com/users';
  final String username;

  GithubService(this.username);

  Future<GithubStats> fetchStats() async {
    try {
      // Fetch user profile
      final userResponse = await http.get(Uri.parse('$_baseUrl/$username'));
      if (userResponse.statusCode != 200) {
        throw Exception('Failed to load GitHub profile');
      }
      final userData = json.decode(userResponse.body);

      // Fetch repositories
      final reposResponse = await http.get(
        Uri.parse('$_baseUrl/$username/repos?per_page=100&sort=updated'),
      );
      if (reposResponse.statusCode != 200) {
        throw Exception('Failed to load GitHub repositories');
      }
      final List<dynamic> reposData = json.decode(reposResponse.body);

      return GithubStats.fromJson(userData, reposData);
    } catch (e) {
      throw Exception('Error fetching GitHub data: $e');
    }
  }
}
