import 'package:either_dart/either.dart';
import 'package:ranking/domain/entities/errors.dart';
import 'package:ranking/domain/entities/ranking_item.dart';

abstract class RankingLocalDatasource {
  Future<Either<MainError, List<RankingItem>>> getDefaultRanking();
  Future<Either<MainError, String>> getDefaultRankingSearch();
}
