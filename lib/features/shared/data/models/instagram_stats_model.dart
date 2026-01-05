class InstagramStats {
  final String username;
  final String posts;
  final String followers;
  final String headline;
  final String? profileImageUrl;

  InstagramStats({
    required this.username,
    required this.posts,
    required this.followers,
    required this.headline,
    this.profileImageUrl,
  });
}
