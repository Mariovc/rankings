import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:ranking/domain/entities/errors.dart';
import 'package:ranking/domain/repositories/ranking_repository.dart';

@Injectable()
class GetImageUrlUseCase {
  final RankingRepository repository;

  GetImageUrlUseCase(this.repository);

  Future<Either<MainError, String>> call({
    required String query,
  }) {
    return repository.getImageUrl(query: query);
  }
}
