import 'package:either_dart/either.dart';
import 'package:images/data/datasources/ranking/ranking_remote_datasource.dart';
import 'package:images/domain/entities/errors.dart';
import 'package:images/domain/entities/ranking_item.dart';
import 'package:images/domain/repositories/ranking_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RankingRepository)
class RankingRepositoryImpl implements RankingRepository {
  final RankingRemoteDatasource remoteDataSource;

  RankingRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<MainError, List<RankingItem>>> getRanking({
    required String query,
  }) {
    return remoteDataSource.getRanking(query: query);
  }
}