import 'package:flutter/material.dart';
import 'package:my_protfolio/features/blog/data/models/blog_post_model.dart';
import 'package:my_protfolio/features/blog/presentation/widgets/blog_card_widget.dart';

class BlogPostsList extends StatelessWidget {
  final List<BlogPost> posts;
  final bool isMobile;
  final bool isDark;
  final ScrollController scrollController;
  final IconData Function(String category) getCategoryIcon;
  final String Function(DateTime date) formatDate;
  final Future<void> Function(String url) onLaunchUrl;
  final void Function(BlogPost post) onShowDetailDialog;

  const BlogPostsList({
    super.key,
    required this.posts,
    required this.isMobile,
    required this.isDark,
    required this.scrollController,
    required this.getCategoryIcon,
    required this.formatDate,
    required this.onLaunchUrl,
    required this.onShowDetailDialog,
  });

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Text(
          'No blog posts available.',
          style: TextStyle(
            color: isDark ? Colors.white70 : Colors.black54,
            fontSize: 16,
          ),
        ),
      );
    }

    return SizedBox(
      height: isMobile ? 500 : 600,
      child: Scrollbar(
        controller: scrollController,
        child: ListView.builder(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 20),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Container(
              margin: EdgeInsets.only(right: isMobile ? 20 : 30),
              width: isMobile ? 300 : 400,
              height: isMobile ? 500 : 600,
              child: BlogCardWidget(
                post: post,
                isMobile: isMobile,
                isDark: isDark,
                getCategoryIcon: getCategoryIcon,
                formatDate: formatDate,
                onLaunchUrl: onLaunchUrl,
                onShowDetailDialog: onShowDetailDialog,
              ),
            );
          },
        ),
      ),
    );
  }
}
