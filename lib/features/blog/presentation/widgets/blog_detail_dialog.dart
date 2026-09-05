import 'package:flutter/material.dart';
import 'package:my_protfolio/features/blog/data/models/blog_post_model.dart';

class BlogDetailDialog extends StatelessWidget {
  final BlogPost post;
  final bool isMobile;
  final bool isDark;
  final IconData Function(String category) getCategoryIcon;
  final String Function(DateTime date) formatDate;
  final Future<void> Function(String url) onLaunchUrl;

  const BlogDetailDialog({
    super.key,
    required this.post,
    required this.isMobile,
    required this.isDark,
    required this.getCategoryIcon,
    required this.formatDate,
    required this.onLaunchUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: isMobile ? double.infinity : 800,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with close button
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E2D3D)
                      : const Color(0xFFEFEFEF),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      post.category.toUpperCase(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? const Color(0xFF64FFDA)
                            : const Color(0xFF0A192F),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Blog image
              if (post.imageUrl.isNotEmpty)
                Container(
                  height: isMobile ? 200 : 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(post.imageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              else
                Container(
                  height: isMobile ? 200 : 300,
                  width: double.infinity,
                  color: isDark
                      ? const Color(0xFF2A3D4F)
                      : const Color(0xFFEFEFEF),
                  child: Icon(
                    getCategoryIcon(post.category),
                    size: isMobile ? 80 : 120,
                    color: isDark
                        ? const Color(0xFF64FFDA)
                        : const Color(0xFF0A192F),
                  ),
                ),

              // Content
              Padding(
                padding: EdgeInsets.all(isMobile ? 20 : 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 32,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Metadata
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF64FFDA).withValues(alpha: 0.15)
                                : const Color(0xFF0A192F).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${post.readTime} min read',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? const Color(0xFF64FFDA)
                                  : const Color(0xFF0A192F),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          formatDate(post.publishedDate),
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: post.tags.take(3).map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF64FFDA).withValues(alpha: 0.15)
                                : const Color(0xFF0A192F).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '#$tag',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? const Color(0xFF64FFDA)
                                  : const Color(0xFF0A192F),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Content
                    Text(
                      post.content.isNotEmpty ? post.content : post.excerpt,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 18,
                        height: 1.8,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // External link button (if available)
                    if (post.externalUrl != null &&
                        post.externalUrl!.isNotEmpty)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => onLaunchUrl(post.externalUrl!),
                          icon: const Icon(Icons.open_in_new),
                          label: const Text('Read Full Article on Medium'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF64FFDA),
                            foregroundColor: const Color(0xFF0A192F),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
