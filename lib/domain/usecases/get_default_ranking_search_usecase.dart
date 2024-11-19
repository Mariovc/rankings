import 'package:either_dart/either.dart';
import 'package:images/domain/entities/errors.dart';
import 'package:images/domain/repositories/ranking_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetDefaultRankingSearchUseCase {
  final RankingRepository repository;

  GetDefaultRankingSearchUseCase(this.repository);

  Future<Either<MainError, String>> call() {
    return repository.getDefaultRankingSearch();
  }
}
