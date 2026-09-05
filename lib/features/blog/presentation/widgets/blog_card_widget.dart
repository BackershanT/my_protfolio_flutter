import 'package:flutter/material.dart';
import 'package:my_protfolio/features/blog/data/models/blog_post_model.dart';
import 'package:my_protfolio/core/constants/colors.dart';
import 'package:my_protfolio/core/utils/threed_effects.dart';

class BlogCardWidget extends StatelessWidget {
  final BlogPost post;
  final bool isMobile;
  final bool isDark;
  final IconData Function(String category) getCategoryIcon;
  final String Function(DateTime date) formatDate;
  final Future<void> Function(String url) onLaunchUrl;
  final void Function(BlogPost post) onShowDetailDialog;

  const BlogCardWidget({
    super.key,
    required this.post,
    required this.isMobile,
    required this.isDark,
    required this.getCategoryIcon,
    required this.formatDate,
    required this.onLaunchUrl,
    required this.onShowDetailDialog,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDark ? AppColors.primaryLight : AppColors.primaryDark;

    return TiltCard(
      maxTilt: isMobile ? 0 : 14,
      scale: isMobile ? 1.0 : 1.03,
      glareOpacity: 0.12,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF112240) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: primaryColor.withValues(alpha: 0.15),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withValues(alpha: isDark ? 0.12 : 0.06),
              blurRadius: 30,
              spreadRadius: 2,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blog image container
            Container(
              height: isMobile ? 180 : 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                image: post.imageUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(post.imageUrl),
                        fit: BoxFit.fill,
                      )
                    : null,
                color: post.imageUrl.isEmpty
                    ? (isDark ? const Color(0xFF1E3A5F) : const Color(0xFFEFF3FF))
                    : null,
              ),
              child: post.imageUrl.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            getCategoryIcon(post.category),
                            size: isMobile ? 56 : 72,
                            color: primaryColor.withValues(alpha: 0.6),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              post.category.toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : null,
            ),

            // Content area
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 20 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Blog title
                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 10),

                    // Tags
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: post.tags.take(3).map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '#$tag',
                            style: TextStyle(
                              fontSize: isMobile ? 11 : 12,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 8),

                    // Blog excerpt
                    Flexible(
                      child: Text(
                        post.excerpt,
                        style: TextStyle(
                          fontSize: isMobile ? 13 : 14,
                          height: 1.55,
                          color: isDark ? Colors.white60 : Colors.black54,
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: true,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Meta row + button
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                post.category.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                            Text(
                              '${post.readTime} min read',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark ? Colors.white54 : Colors.black38,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        Text(
                          formatDate(post.publishedDate),
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? Colors.white38 : Colors.black26,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Action button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (post.externalUrl != null &&
                                  post.externalUrl!.isNotEmpty) {
                                onLaunchUrl(post.externalUrl!);
                              } else {
                                onShowDetailDialog(post);
                              }
                            },
                            icon: const Icon(Icons.open_in_new, size: 16),
                            label: const Text('Read Article'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: isDark
                                  ? AppColors.darkBackground
                                  : Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 14 : 18,
                                vertical: isMobile ? 10 : 12,
                              ),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
