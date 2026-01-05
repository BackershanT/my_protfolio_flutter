import '../models/linkedin_stats_model.dart';

class LinkedInService {
  // Update these values whenever your LinkedIn profile grows!
  static final LinkedInStats _mockStats = LinkedInStats(
    username: 'Backershan T',
    connections: '500+',
    endorsements: '15+',
    followers: '595',
    headline:
        'Flutter Developer | Sharing Real-World Flutter Performance & Architecture Insights | Mobile & Frontend',
    profileImageUrl: 'https://www.linkedin.com/in/backershan-t/',
  );

  Future<LinkedInStats> fetchStats() async {
    // Simulate a network delay to match the GitHub service feel
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockStats;
  }
}
