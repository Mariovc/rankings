// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RankingItemCWProxy {
  RankingItem title(String title);

  RankingItem description(String description);

  RankingItem imageUrl(String? imageUrl);

  RankingItem rating(double? rating);

  RankingItem awards(List<String> awards);

  RankingItem categories(List<String> categories);

  RankingItem link(String? link);

  RankingItem timestamp(DateTime? timestamp);

  RankingItem countryCode(String? countryCode);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RankingItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RankingItem(...).copyWith(id: 12, name: "My name")
  /// ````
  RankingItem call({
    String? title,
    String? description,
    String? imageUrl,
    double? rating,
    List<String>? awards,
    List<String>? categories,
    String? link,
    DateTime? timestamp,
    String? countryCode,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRankingItem.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRankingItem.copyWith.fieldName(...)`
class _$RankingItemCWProxyImpl implements _$RankingItemCWProxy {
  const _$RankingItemCWProxyImpl(this._value);

  final RankingItem _value;

  @override
  RankingItem title(String title) => this(title: title);

  @override
  RankingItem description(String description) => this(description: description);

  @override
  RankingItem imageUrl(String? imageUrl) => this(imageUrl: imageUrl);

  @override
  RankingItem rating(double? rating) => this(rating: rating);

  @override
  RankingItem awards(List<String> awards) => this(awards: awards);

  @override
  RankingItem categories(List<String> categories) =>
      this(categories: categories);

  @override
  RankingItem link(String? link) => this(link: link);

  @override
  RankingItem timestamp(DateTime? timestamp) => this(timestamp: timestamp);

  @override
  RankingItem countryCode(String? countryCode) =>
      this(countryCode: countryCode);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RankingItem(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RankingItem(...).copyWith(id: 12, name: "My name")
  /// ````
  RankingItem call({
    Object? title = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? imageUrl = const $CopyWithPlaceholder(),
    Object? rating = const $CopyWithPlaceholder(),
    Object? awards = const $CopyWithPlaceholder(),
    Object? categories = const $CopyWithPlaceholder(),
    Object? link = const $CopyWithPlaceholder(),
    Object? timestamp = const $CopyWithPlaceholder(),
    Object? countryCode = const $CopyWithPlaceholder(),
  }) {
    return RankingItem(
      title: title == const $CopyWithPlaceholder() || title == null
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      description:
          description == const $CopyWithPlaceholder() || description == null
              ? _value.description
              // ignore: cast_nullable_to_non_nullable
              : description as String,
      imageUrl: imageUrl == const $CopyWithPlaceholder()
          ? _value.imageUrl
          // ignore: cast_nullable_to_non_nullable
          : imageUrl as String?,
      rating: rating == const $CopyWithPlaceholder()
          ? _value.rating
          // ignore: cast_nullable_to_non_nullable
          : rating as double?,
      awards: awards == const $CopyWithPlaceholder() || awards == null
          ? _value.awards
          // ignore: cast_nullable_to_non_nullable
          : awards as List<String>,
      categories:
          categories == const $CopyWithPlaceholder() || categories == null
              ? _value.categories
              // ignore: cast_nullable_to_non_nullable
              : categories as List<String>,
      link: link == const $CopyWithPlaceholder()
          ? _value.link
          // ignore: cast_nullable_to_non_nullable
          : link as String?,
      timestamp: timestamp == const $CopyWithPlaceholder()
          ? _value.timestamp
          // ignore: cast_nullable_to_non_nullable
          : timestamp as DateTime?,
      countryCode: countryCode == const $CopyWithPlaceholder()
          ? _value.countryCode
          // ignore: cast_nullable_to_non_nullable
          : countryCode as String?,
    );
  }
}

extension $RankingItemCopyWith on RankingItem {
  /// Returns a callable class that can be used as follows: `instanceOfRankingItem.copyWith(...)` or like so:`instanceOfRankingItem.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RankingItemCWProxy get copyWith => _$RankingItemCWProxyImpl(this);
}
