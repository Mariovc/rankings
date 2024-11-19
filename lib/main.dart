import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ranking/core/di/injection.dart';
import 'package:ranking/presentation/navigation/main_navigation.dart';
import 'package:ranking/presentation/styles/theme.dart';
import 'package:ranking/presentation/util/globals.dart';

void main() async {
  configureDependencies(env: const String.fromEnvironment('ENVIRONMENT'));

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('es')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter router = getIt<MainNavigation>().router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: darkThemeData,
      scaffoldMessengerKey: scaffoldMessengerKey,
    );
  }
}
