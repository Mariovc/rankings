// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:ranking/core/di/environment.dart' as _i755;
import 'package:ranking/core/di/injection.dart' as _i882;
import 'package:ranking/data/datasources/ranking/ranking_local_datasource.dart'
    as _i697;
import 'package:ranking/data/datasources/ranking/ranking_local_datasource_implementation.dart'
    as _i798;
import 'package:ranking/data/datasources/ranking/ranking_remote_datasource.dart'
    as _i51;
import 'package:ranking/data/datasources/ranking/ranking_remote_datasource_implementation.dart'
    as _i390;
import 'package:ranking/data/repositories/ranking_repository_impl.dart'
    as _i506;
import 'package:ranking/data/services/api_service.dart' as _i894;
import 'package:ranking/domain/repositories/ranking_repository.dart' as _i749;
import 'package:ranking/domain/usecases/get_default_ranking_search_usecase.dart'
    as _i746;
import 'package:ranking/domain/usecases/get_image_url_usecase.dart' as _i804;
import 'package:ranking/domain/usecases/get_ranking_usecase.dart' as _i731;
import 'package:ranking/presentation/navigation/main_navigation.dart' as _i708;
import 'package:ranking/presentation/viewmodels/home_viewmodel.dart' as _i910;

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
    gh.singleton<_i755.Env>(() => diModule.env);
    gh.singleton<_i708.MainNavigation>(() => diModule.navigator);
    gh.singleton<_i974.Logger>(() => diModule.logger);
    gh.lazySingleton<_i894.ApiService>(() => apiServiceModule.httpClient);
    gh.factory<_i697.RankingLocalDatasource>(
        () => _i798.RankingAsset(gh<_i974.Logger>()));
    gh.factory<_i51.RankingRemoteDatasource>(() => _i390.RankingChatGpt(
          gh<_i974.Logger>(),
          gh<_i894.ApiService>(),
          gh<_i755.Env>(),
        ));
    gh.factory<_i749.RankingRepository>(() => _i506.RankingRepositoryImpl(
          gh<_i697.RankingLocalDatasource>(),
          gh<_i51.RankingRemoteDatasource>(),
        ));
    gh.factory<_i746.GetDefaultRankingSearchUseCase>(() =>
        _i746.GetDefaultRankingSearchUseCase(gh<_i749.RankingRepository>()));
    gh.factory<_i731.GetRankingUseCase>(
        () => _i731.GetRankingUseCase(gh<_i749.RankingRepository>()));
    gh.factory<_i804.GetImageUrlUseCase>(
        () => _i804.GetImageUrlUseCase(gh<_i749.RankingRepository>()));
    gh.factory<_i910.HomeViewModel>(() => _i910.HomeViewModel(
          gh<_i974.Logger>(),
          gh<_i731.GetRankingUseCase>(),
          gh<_i746.GetDefaultRankingSearchUseCase>(),
          gh<_i804.GetImageUrlUseCase>(),
        ));
    return this;
  }
}

class _$DiModule extends _i882.DiModule {}

class _$ApiServiceModule extends _i894.ApiServiceModule {}
