import 'package:get_it/get_it.dart';
import 'package:ranking/core/di/environment.dart';
import 'package:ranking/presentation/navigation/main_navigation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
void configureDependencies({required String env}) =>
    getIt.init(environment: env);

@module
abstract class DiModule {
  @Singleton()
  Env get env => EnvConfig();

  @Singleton()
  MainNavigation get navigator => MainNavigation();

  @Singleton()
  Logger get logger => Logger();
}
