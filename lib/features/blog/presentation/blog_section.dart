import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_protfolio/features/blog/data/models/blog_post_model.dart';
import 'package:my_protfolio/features/blog/data/models/blog_data.dart';
import 'package:my_protfolio/features/shared/core/constants/colors.dart';
import 'package:my_protfolio/features/shared/presentation/section_title.dart';
import 'package:url_launcher/url_launcher.dart';

class BlogSection extends StatefulWidget {
  const BlogSection({super.key});

  @override
  State<BlogSection> createState() => _BlogSectionState();
}

class _BlogSectionState extends State<BlogSection> {
  List<BlogPost> _posts = [];
  bool _isLoading = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadPosts() async {
    try {
      // Use static posts since we removed the Medium fetching
      final posts = BlogData.getAllPosts();
      if (mounted) {
        setState(() {
          _posts = posts;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _posts = BlogData.getAllPosts();
          _isLoading = false;
        });
      }
    }
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
          SectionTitle(
            title: 'Latest Blog Posts',
            subtitle: 'Thoughts on Flutter, React, and Frontend Development',
          ),
          SizedBox(height: isMobile ? 30 : 50),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            _buildBlogPosts(context, isMobile, isDark),
        ],
      ),
    );
  }

  Widget _buildBlogPosts(BuildContext context, bool isMobile, bool isDark) {
    if (_posts.isEmpty) {
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
        controller: _scrollController,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(vertical: 20),
          itemCount: _posts.length,
          itemBuilder: (context, index) {
            final post = _posts[index];
            return Container(
              margin: EdgeInsets.only(right: isMobile ? 20 : 30),
              width: isMobile ? 300 : (isMobile ? 350 : 400),
              height: isMobile ? 500 : (isMobile ? 550 : 600),
              child: _buildBlogCard(context, post, isMobile, isDark),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBlogCard(BuildContext context, BlogPost post, bool isMobile, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E2D3D) : const Color(0xFFFEF7FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark 
              ? Colors.white.withValues(alpha: 0.1) 
              : Colors.black.withValues(alpha: 0.05),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withValues(alpha: 0.2) 
                : Colors.grey.withValues(alpha: 0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              image: post.imageUrl.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(post.imageUrl),
                      fit: BoxFit.fill,
                    )
                  : null,
              color: post.imageUrl.isEmpty
                  ? (isDark ? const Color(0xFF2A3D4F) : const Color(0xFFEFEFEF))
                  : null,
            ),
            child: post.imageUrl.isEmpty
                ? Icon(
                    _getCategoryIcon(post.category),
                    size: isMobile ? 60 : 80,
                    color: isDark ? const Color(0xFF64FFDA) : const Color(0xFF0A192F),
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
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: post.tags.map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: isDark 
                              ? const Color(0xFF64FFDA).withValues(alpha: 0.15) 
                              : const Color(0xFF0A192F).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontSize: isMobile ? 11 : 13,
                            fontWeight: FontWeight.w500,
                            color: isDark ? const Color(0xFF64FFDA) : const Color(0xFF0A192F),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Blog excerpt
                  Flexible(
                    child: Text(
                      post.excerpt,
                      style: TextStyle(
                        fontSize: isMobile ? 13 : 15,
                        height: 1.5,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      overflow: TextOverflow.fade,
                      softWrap: true,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Action buttons and metadata
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Read time and date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: isDark 
                                  ? const Color(0xFF64FFDA).withValues(alpha: 0.15) 
                                  : const Color(0xFF0A192F).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              post.category.toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: isDark ? const Color(0xFF64FFDA) : const Color(0xFF0A192F),
                              ),
                            ),
                          ),
                          Text(
                            '${post.readTime} min read',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      Text(
                        _formatDate(post.publishedDate),
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white54 : Colors.black38,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Action button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (post.externalUrl != null && post.externalUrl!.isNotEmpty) {
                              _launchUrl(post.externalUrl!);
                            } else {
                              // Show blog detail dialog
                              _showBlogDetailDialog(context, post, isMobile, isDark);
                            }
                          },
                          icon: const Icon(
                            Icons.open_in_new,
                            size: 18,
                          ),
                          label: const Text('Read Article'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF64FFDA),
                            foregroundColor: const Color(0xFF0A192F),
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 16 : 20,
                              vertical: isMobile ? 10 : 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
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
    );
  }

  void _showBlogDetailDialog(
    BuildContext context,
    BlogPost post,
    bool isMobile,
    bool isDark,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                        _getCategoryIcon(post.category),
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
                                    ? const Color(
                                        0xFF64FFDA,
                                      ).withValues(alpha: 0.15)
                                    : const Color(
                                        0xFF0A192F,
                                      ).withValues(alpha: 0.1),
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
                              _formatDate(post.publishedDate),
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
                          children: post.tags.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(
                                        0xFF64FFDA,
                                      ).withValues(alpha: 0.15)
                                    : const Color(
                                        0xFF0A192F,
                                      ).withValues(alpha: 0.1),
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
                              onPressed: () => _launchUrl(post.externalUrl!),
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
      },
    );
  }
}
