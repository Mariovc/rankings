import 'package:ranking/data/services/dio_service.dart';
import 'package:ranking/data/transformers/error_transformer.dart';
import 'package:ranking/domain/entities/errors.dart';
import 'package:injectable/injectable.dart';

class ApiService extends DioRestService<MainError> {
  ApiService()
      : super(
          validCodes: [200, 201, 204],
          catchErrors: errorsHandler,
        );
}

@module
abstract class ApiServiceModule {
  @lazySingleton
  ApiService get httpClient => ApiService();
}
