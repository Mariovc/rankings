import 'package:either_dart/either.dart';
import 'package:ranking/domain/entities/errors.dart';
import 'package:ranking/domain/entities/ranking_item.dart';
import 'package:ranking/domain/repositories/ranking_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetRankingUseCase {
  final RankingRepository repository;

  GetRankingUseCase(this.repository);

  Future<Either<MainError, List<RankingItem>>> call({
    required String query,
  }) {
    return repository.getRanking(query: query);
  }
}
