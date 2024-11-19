class RankingItem {
  final String title;
  final String description;
  final String imageUrl;
  final double rating;
  final int score;
  final String location;
  final List<String> awards;
  final List<String> categories;
  final String dominantColor;
  final String link;
  final String price;
  final int likes;
  final DateTime timestamp;
  final String country;

  RankingItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.score,
    required this.location,
    required this.awards,
    required this.categories,
    required this.dominantColor,
    required this.link,
    required this.price,
    required this.likes,
    required this.timestamp,
    required this.country,
  });
}
