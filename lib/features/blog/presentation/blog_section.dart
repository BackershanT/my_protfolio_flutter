import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:my_protfolio/core/presentation/widgets/section_title.dart';
import 'package:my_protfolio/features/admin/data/providers/admin_blog_provider.dart';
import 'package:my_protfolio/features/blog/data/models/blog_post_model.dart';
import 'package:my_protfolio/features/blog/presentation/widgets/blog_detail_dialog.dart';
import 'package:my_protfolio/features/blog/presentation/widgets/blog_posts_list.dart';
import 'package:my_protfolio/features/blog/presentation/widgets/blog_skeleton_posts.dart';

class BlogSection extends StatefulWidget {
  const BlogSection({super.key});

  @override
  State<BlogSection> createState() => _BlogSectionState();
}

class _BlogSectionState extends State<BlogSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminBlogProvider>().loadBlogs();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open the link. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error opening link: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'flutter':
        return Icons.phone_android_rounded;
      case 'react':
        return Icons.web_rounded;
      case 'design':
        return Icons.palette_rounded;
      default:
        return Icons.article_rounded;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showBlogDetailDialog(BlogPost post, bool isMobile, bool isDark) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlogDetailDialog(
          post: post,
          isMobile: isMobile,
          isDark: isDark,
          getCategoryIcon: _getCategoryIcon,
          formatDate: _formatDate,
          onLaunchUrl: _launchUrl,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 850;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : (screenWidth < 1200 ? 40 : 100),
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Latest Blog Posts',
            subtitle: 'Thoughts on Flutter, React, and Frontend Development',
          ),
          SizedBox(height: isMobile ? 30 : 50),
          Consumer<AdminBlogProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading && provider.blogs.isEmpty) {
                return BlogSkeletonPosts(
                  isMobile: isMobile,
                  isDark: isDark,
                );
              }

              if (provider.blogs.isEmpty) {
                return BlogPostsList(
                  posts: const [],
                  isMobile: isMobile,
                  isDark: isDark,
                  scrollController: _scrollController,
                  getCategoryIcon: _getCategoryIcon,
                  formatDate: _formatDate,
                  onLaunchUrl: _launchUrl,
                  onShowDetailDialog: (post) =>
                      _showBlogDetailDialog(post, isMobile, isDark),
                );
              }

              final posts = provider.blogs.map((b) {
                return BlogPost(
                  id: b.title,
                  title: b.title,
                  excerpt: b.description.length > 130
                      ? '${b.description.substring(0, 130)}...'
                      : b.description,
                  content: b.description,
                  category: b.technologies.isNotEmpty
                      ? b.technologies.first
                      : 'Tech',
                  imageUrl: b.imageUrl,
                  publishedDate: DateTime.tryParse(b.date) ?? DateTime.now(),
                  readTime: 5,
                  tags: b.technologies,
                );
              }).toList();

              return BlogPostsList(
                posts: posts,
                isMobile: isMobile,
                isDark: isDark,
                scrollController: _scrollController,
                getCategoryIcon: _getCategoryIcon,
                formatDate: _formatDate,
                onLaunchUrl: _launchUrl,
                onShowDetailDialog: (post) =>
                    _showBlogDetailDialog(post, isMobile, isDark),
              );
            },
          ),
        ],
      ),
    );
  }
}
