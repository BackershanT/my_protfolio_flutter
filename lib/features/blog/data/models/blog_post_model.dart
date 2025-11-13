class BlogPost {
  final String id;
  final String title;
  final String excerpt;
  final String content;
  final String category;
  final String imageUrl;
  final DateTime publishedDate;
  final int readTime; // in minutes
  final List<String> tags;
  final String? externalUrl; // Medium article URL

  BlogPost({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.category,
    required this.imageUrl,
    required this.publishedDate,
    required this.readTime,
    required this.tags,
    this.externalUrl,
  });
}