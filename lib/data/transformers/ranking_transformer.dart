import 'package:images/domain/entities/ranking_item.dart';

class RankingTransformer {
  static RankingItem fromJson(Map<String, dynamic> json) {
    return RankingItem(
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      rating: json['rating'],
      score: json['score'],
      location: json['location'],
      awards: List<String>.from(json['awards']),
      categories: List<String>.from(json['categories']),
      dominantColor: json['dominant_color'],
      link: json['link'],
      price: json['price'],
      likes: json['likes'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] * 1000),
      country: json['country'],
    );
  }
}