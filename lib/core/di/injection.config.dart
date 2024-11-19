// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:images/core/di/environment.dart' as _i925;
import 'package:images/core/di/injection.dart' as _i439;
import 'package:images/data/datasources/ranking/ranking_local_datasource.dart'
    as _i453;
import 'package:images/data/datasources/ranking/ranking_local_datasource_implementation.dart'
    as _i853;
import 'package:images/data/datasources/ranking/ranking_remote_datasource.dart'
    as _i585;
import 'package:images/data/datasources/ranking/ranking_remote_datasource_implementation.dart'
    as _i817;
import 'package:images/data/repositories/ranking_repository_impl.dart' as _i750;
import 'package:images/data/services/api_service.dart' as _i618;
import 'package:images/domain/repositories/ranking_repository.dart' as _i239;
import 'package:images/domain/usecases/get_default_ranking_search_usecase.dart'
    as _i704;
import 'package:images/domain/usecases/get_ranking_usecase.dart' as _i1065;
import 'package:images/presentation/navigation/main_navigation.dart' as _i873;
import 'package:images/presentation/viewmodels/home_viewmodel.dart' as _i510;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final diModule = _$DiModule();
    final apiServiceModule = _$ApiServiceModule();
    gh.singleton<_i925.Env>(() => diModule.env);
    gh.singleton<_i873.MainNavigation>(() => diModule.navigator);
    gh.singleton<_i974.Logger>(() => diModule.logger);
    gh.lazySingleton<_i618.ApiService>(() => apiServiceModule.httpClient);
    gh.factory<_i453.RankingLocalDatasource>(
        () => _i853.RankingAsset(gh<_i974.Logger>()));
    gh.factory<_i585.RankingRemoteDatasource>(() => _i817.RankingChatGpt(
          gh<_i618.ApiService>(),
          gh<_i925.Env>(),
        ));
    gh.factory<_i239.RankingRepository>(() => _i750.RankingRepositoryImpl(
          gh<_i453.RankingLocalDatasource>(),
          gh<_i585.RankingRemoteDatasource>(),
        ));
    gh.factory<_i1065.GetRankingUseCase>(
        () => _i1065.GetRankingUseCase(gh<_i239.RankingRepository>()));
    gh.factory<_i704.GetDefaultRankingSearchUseCase>(() =>
        _i704.GetDefaultRankingSearchUseCase(gh<_i239.RankingRepository>()));
    gh.factory<_i510.HomeViewModel>(() => _i510.HomeViewModel(
          gh<_i1065.GetRankingUseCase>(),
          gh<_i704.GetDefaultRankingSearchUseCase>(),
        ));
    return this;
  }
}

class _$DiModule extends _i439.DiModule {}

class _$ApiServiceModule extends _i618.ApiServiceModule {}
