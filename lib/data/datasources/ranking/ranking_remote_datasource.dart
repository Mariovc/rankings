import 'package:either_dart/either.dart';
import 'package:ranking/domain/entities/errors.dart';
import 'package:ranking/domain/entities/ranking_item.dart';

abstract class RankingRemoteDatasource {
  Future<Either<MainError, List<RankingItem>>> getRanking({
    required String query,
  });
  Future<Either<MainError, String>> getImageUrl({
    required String query,
  });
}
