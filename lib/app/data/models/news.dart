class NewsItem {
  final String title;
  final String subtitle;
  final String category;
  final String date;
  final String imageUrl;
  final bool? popular;
  NewsItem({
    required this.title,
    required this.subtitle,
    required this.category,
    required this.date,
    required this.imageUrl,
    this.popular,
  });
}
