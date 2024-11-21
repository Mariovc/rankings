import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:logger/logger.dart';
import 'package:ranking/core/di/environment.dart';
import 'package:ranking/data/datasources/ranking/ranking_remote_datasource.dart';
import 'package:ranking/data/services/api_service.dart';
import 'package:ranking/data/transformers/ranking_transformer.dart';
import 'package:ranking/domain/entities/errors.dart';
import 'package:ranking/domain/entities/ranking_item.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RankingRemoteDatasource)
class RankingChatGpt implements RankingRemoteDatasource {
  final Logger logger;
  final ApiService _apiService;
  final Env _envConfig;

  static const String chatModel = 'gpt-4o';
  static const String chatSystemMessage =
      "You are an AI assistant that generates detailed, structured rankings in JSON format as a list of items without comments, just JSON. Each ranking item should include a title (60 characters maximum but as short as possible), description (120 characters maximum), rating (out of 5), countryCode (origin or author's origin in ISO with 2 digits), awards, categories or tags, link, and timestamp (creation date or birthdate in seconds). If any of these parameters are not applicable or available, just set them to null. Detect the user's language to give a response in the same language.";
  static const int chatMaxTokens = 2000;
  static const double chatTemperature = 0.7;

  static const String imageSize = '256x256';

  RankingChatGpt(this.logger, this._apiService, this._envConfig);

  @override
  Future<Either<MainError, List<RankingItem>>> getRanking({
    required String query,
  }) async {
    final String requestBody = '''
    {
      "model": "$chatModel",
      "messages": [
        {
          "role": "system",
          "content": "$chatSystemMessage"
        },
        {
          "role": "user",
          "content": "$query"
        }
      ],
      "max_tokens": $chatMaxTokens,
      "temperature": $chatTemperature
    }
    ''';

    return _apiService.post<String>(
        Uri.https(_envConfig.baseUrl, '/v1/chat/completions'),
        data: requestBody,
        headers: {
          'Authorization': 'Bearer ${_envConfig.apiKey}',
          'Content-Type': 'application/json',
        }).thenRight((response) => parseResponse(response));
  }

  Future<Either<MainError, List<RankingItem>>> parseResponse(
    String jsonResponse,
  ) async {
    logger.d('Parsing response: $jsonResponse');

    final regex = RegExp(r'```json\s*(.+?)\s*```', dotAll: true);
    final match = regex.firstMatch(jsonResponse);

    if (match != null) {
      // The captured group contains the JSON content
      String jsonString = match.group(1)!;

      // Remove newlines and quotes
      jsonString = jsonString.replaceAll(r'\n', '').replaceAll(r'\"', '"');

      try {
        List<dynamic> jsonList = jsonDecode(jsonString);

        logger.i('Parsed JSON with ${jsonList.length} items');

        // Process the list into Ranking item objects
        List<RankingItem> rankingItems = jsonList
            .map((itemJson) => RankingTransformer.fromJson(itemJson))
            .toList();

        for (var item in rankingItems) {
          logger.i('Ranking Item: ${item.title}, Rating: ${item.rating}');
        }
        return Right(rankingItems);
      } on FormatException catch (e) {
        logger.e('Invalid JSON format: ${e.message}');
        return Left(ParsingError());
      }
    } else {
      logger.e('No JSON content found');
      return Left(ParsingError());
    }
  }

  @override
  Future<Either<MainError, String>> getImageUrl({
    required String rankingQuery,
    required String title,
  }) async {
    final String requestBody = '''
    {
      "prompt": "Image of '$title' for this ranking: '$rankingQuery'",
      "n": 1,
      "size": "$imageSize"
    }
    ''';

    return _apiService.post<String>(
      Uri.https(_envConfig.baseUrl, '/v1/images/generations'),
      data: requestBody,
      headers: {
        'Authorization': 'Bearer ${_envConfig.apiKey}',
        'Content-Type': 'application/json',
      },
    ).mapRight((response) {
      final data = jsonDecode(response);
      return data['data'][0]['url'];
    });
  }
}
