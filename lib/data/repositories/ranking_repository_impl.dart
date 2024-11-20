import 'package:either_dart/either.dart';
import 'package:ranking/data/datasources/ranking/ranking_local_datasource.dart';
import 'package:ranking/data/datasources/ranking/ranking_remote_datasource.dart';
import 'package:ranking/domain/entities/errors.dart';
import 'package:ranking/domain/entities/ranking_item.dart';
import 'package:ranking/domain/repositories/ranking_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RankingRepository)
class RankingRepositoryImpl implements RankingRepository {
  final RankingLocalDatasource localDataSource;
  final RankingRemoteDatasource remoteDataSource;

  RankingRepositoryImpl(
    this.localDataSource,
    this.remoteDataSource,
  );

  @override
  Future<Either<MainError, List<RankingItem>>> getRanking({
    required String query,
  }) {
    if (query.isEmpty) {
      return localDataSource.getDefaultRanking();
    } else {
      return remoteDataSource.getRanking(query: query);
    }
  }

  @override
  Future<Either<MainError, String>> getDefaultRankingSearch() {
    return localDataSource.getDefaultRankingSearch();
  }

  @override
  Future<Either<MainError, String>> getImageUrl({
    required String query,
  }) {
    return remoteDataSource.getImageUrl(query: query);
  }
}
