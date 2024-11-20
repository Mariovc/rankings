import 'package:ranking/domain/entities/ranking_item.dart';

class RankingTransformer {
  static RankingItem fromJson(Map<String, dynamic> json) {
    return RankingItem(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble(),
      countryCode: json['countryCode'] as String?,
      awards: (json['awards'] as List<dynamic>?)
              ?.map((award) => award as String)
              .toList() ??
          [],
      categories: (json['categories'] as List<dynamic>?)
              ?.map((category) => category as String)
              .toList() ??
          [],
      link: json['link'] as String?,
      timestamp: json['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['timestamp'] * 1000)
          : null,
      imageUrl: json['image_url'] as String?,
    );
  }
}
