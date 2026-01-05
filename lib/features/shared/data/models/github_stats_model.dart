class GithubStats {
  final String username;
  final String avatarUrl;
  final int publicRepos;
  final int followers;
  final int following;
  final int totalStars;
  final List<GithubRepo> topRepos;

  GithubStats({
    required this.username,
    required this.avatarUrl,
    required this.publicRepos,
    required this.followers,
    required this.following,
    required this.totalStars,
    required this.topRepos,
  });

  factory GithubStats.fromJson(
    Map<String, dynamic> userJson,
    List<dynamic> reposJson,
  ) {
    int stars = 0;
    List<GithubRepo> repos = [];

    for (var repo in reposJson) {
      stars += (repo['stargazers_count'] as int);
      repos.add(GithubRepo.fromJson(repo));
    }

    // Sort by stars descending and take top 3
    repos.sort((a, b) => b.stars.compareTo(a.stars));
    final top3 = repos.take(3).toList();

    return GithubStats(
      username: userJson['login'] ?? '',
      avatarUrl: userJson['avatar_url'] ?? '',
      publicRepos: userJson['public_repos'] ?? 0,
      followers: userJson['followers'] ?? 0,
      following: userJson['following'] ?? 0,
      totalStars: stars,
      topRepos: top3,
    );
  }
}

class GithubRepo {
  final String name;
  final String description;
  final int stars;
  final String language;
  final String url;

  GithubRepo({
    required this.name,
    required this.description,
    required this.stars,
    required this.language,
    required this.url,
  });

  factory GithubRepo.fromJson(Map<String, dynamic> json) {
    return GithubRepo(
      name: json['name'] ?? '',
      description: json['description'] ?? 'No description',
      stars: json['stargazers_count'] ?? 0,
      language: json['language'] ?? 'Unknown',
      url: json['html_url'] ?? '',
    );
  }
}
