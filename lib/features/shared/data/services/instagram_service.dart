import '../models/instagram_stats_model.dart';
import '../../core/config/stats_config.dart';

class InstagramService {
  Future<InstagramStats> fetchStats() async {
    // Note: Instagram API requires OAuth or specialized scrapers.
    // This connects to the central config for easy updates.
    await Future.delayed(const Duration(milliseconds: 1000));

    return InstagramStats(
      username: StatsConfig.instagramUsername,
      posts: StatsConfig.instagramPosts,
      followers: StatsConfig.instagramFollowers,
      headline: StatsConfig.instagramHeadline,
      profileImageUrl: StatsConfig.instagramImage,
    );
  }
}
