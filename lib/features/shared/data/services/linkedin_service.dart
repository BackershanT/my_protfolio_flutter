import '../models/linkedin_stats_model.dart';
import '../../core/config/stats_config.dart';

class LinkedInService {
  Future<LinkedInStats> fetchStats() async {
    // Note: Direct scraping of LinkedIn on Flutter Web is usually blocked by CORS.
    // In a real-world production app, this would be fetched via a backend proxy/cloud function.
    await Future.delayed(const Duration(milliseconds: 800));

    return LinkedInStats(
      username: StatsConfig.linkedinName,
      connections: StatsConfig.linkedinConnections,
      endorsements: '',
      followers: StatsConfig.linkedinFollowers,
      headline: StatsConfig.linkedinHeadline,
      profileImageUrl: StatsConfig.linkedinImage,
    );
  }
}
