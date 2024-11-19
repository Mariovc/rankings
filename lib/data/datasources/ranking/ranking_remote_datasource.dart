import 'package:either_dart/either.dart';
import 'package:images/domain/entities/errors.dart';
import 'package:images/domain/entities/ranking_item.dart';

abstract class RankingRemoteDatasource {
  Future<Either<MainError, List<RankingItem>>> getRanking({
    required String query,
  });
}
