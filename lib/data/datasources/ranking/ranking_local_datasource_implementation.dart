import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:either_dart/either.dart';
import 'package:images/data/datasources/ranking/ranking_local_datasource.dart';
import 'package:images/data/transformers/ranking_transformer.dart';
import 'package:images/domain/entities/errors.dart';
import 'package:images/domain/entities/ranking_item.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: RankingLocalDatasource)
class RankingAsset implements RankingLocalDatasource {
  final Logger logger;

  RankingAsset(this.logger);

  @override
  Future<Either<MainError, List<RankingItem>>> getDefaultRanking() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/default.json',
      );
      final jsonList = jsonDecode(jsonString) as List;

      // Process the list into RankingItem objects
      List<RankingItem> rankingItems = jsonList
          .map((itemJson) {
            try {
              return RankingTransformer.fromJson(itemJson);
            } catch (e) {
              logger.e('Error transforming item: $itemJson', error: e);
              return null;
            }
          })
          .where((item) => item != null)
          .cast<RankingItem>()
          .toList();

      return Right(rankingItems);
    } catch (e) {
      logger.e(e);
      return Left(UnknownError());
    }
  }

  @override
  Future<Either<MainError, String>> getDefaultRankingSearch() async {
    return const Right(
      'Give me the most 10 books of entrepreneurship',
    );
  }
}
