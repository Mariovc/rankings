import 'package:copy_with_extension/copy_with_extension.dart';

part 'ranking_item.g.dart';

@CopyWith()
class RankingItem {
  final String title;
  final String description;
  final String? imageUrl;
  final double? rating;
  final String? countryCode;
  final List<String> awards;
  final List<String> categories;
  final String? link;
  final DateTime? timestamp;

  RankingItem({
    required this.title,
    required this.description,
    this.imageUrl,
    required this.rating,
    required this.awards,
    required this.categories,
    required this.link,
    required this.timestamp,
    required this.countryCode,
  });
}
