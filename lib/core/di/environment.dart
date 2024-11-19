abstract class Env {
  final String baseUrl;
  final String apiKey;

  const Env({
    required this.baseUrl,
    required this.apiKey,
  });
}

class EnvConfig implements Env {
  @override
  String get apiKey => const String.fromEnvironment("API_KEY");

  @override
  String get baseUrl => const String.fromEnvironment("BASE_URL");
}