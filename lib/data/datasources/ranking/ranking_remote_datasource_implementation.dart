import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:ranking/core/di/environment.dart';
import 'package:ranking/data/datasources/ranking/ranking_remote_datasource.dart';
import 'package:ranking/data/services/api_service.dart';
import 'package:ranking/data/transformers/ranking_transformer.dart';
import 'package:ranking/domain/entities/errors.dart';
import 'package:ranking/domain/entities/ranking_item.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RankingRemoteDatasource)
class RankingChatGpt implements RankingRemoteDatasource {
  final ApiService _apiService;
  final Env _envConfig;
  final String _defaultQuery = '*';

  RankingChatGpt(this._apiService, this._envConfig);

  // Example JSON response
  String jsonResponse = '''{
	"id": "chatcmpl-AUM3wlEAnXFt7j8YcjaGW2cp0UzER",
	"object": "chat.completion",
	"created": 1731798012,
	"model": "gpt-4o-mini-2024-07-18",
	"choices": [
		{
			"index": 0,
			"message": {
				"role": "assistant",
				"content": "```json\n[\n    {\n        "title": "Catan",\n        "description": "A strategy game where players collect resources to build settlements.",\n        "image_url": "https://example.com/images/catan.jpg",\n        "rating": 4.7,\n        "score": 95,\n        "location": "Germany",\n        "awards": ["Spiel des Jahres 1995"],\n        "categories": ["Strategy", "Resource Management"],\n        "dominant_color": "#FFD700",\n        "link": "https://example.com/catan",\n        "price": "\$44.99",\n        "likes": 12000,\n        "timestamp": 1633046400,\n        "country": "DE"\n    },\n    {\n        "title": "Ticket to Ride",\n        "description": "A railway-themed board game where players claim train routes across the map.",\n        "image_url": "https://example.com/images/ticket_to_ride.jpg",\n        "rating": 4.6,\n        "score": 92,\n        "location": "USA",\n        "awards": ["Spiel des Jahres 2004"],\n        "categories": ["Family", "Strategy"],\n        "dominant_color": "#C0C0C0",\n        "link": "https://example.com/ticket_to_ride",\n        "price": "\$49.99",\n        "likes": 9500,\n        "timestamp": 1633046400,\n        "country": "US"\n    },\n    {\n        "title": "Pandemic",\n        "description": "A cooperative game where players work together to stop global outbreaks.",\n        "image_url": "https://example.com/images/pandemic.jpg",\n        "rating": 4.5,\n        "score": 90,\n        "location": "USA",\n        "awards": ["International Gamers Award 2013"],\n        "categories": ["Cooperative", "Strategy"],\n        "dominant_color": "#FF6347",\n        "link": "https://example.com/pandemic",\n        "price": "\$39.99",\n        "likes": 8000,\n        "timestamp": 1633046400,\n        "country": "ES"\n    }\n]\n```",
				"refusal": null
			},
			"logprobs": null,
			"finish_reason": "stop"
		}
	],
	"usage": {
		"prompt_tokens": 132,
		"completion_tokens": 462,
		"total_tokens": 594,
		"prompt_tokens_details": {
			"cached_tokens": 0,
			"audio_tokens": 0
		},
		"completion_tokens_details": {
			"reasoning_tokens": 0,
			"audio_tokens": 0,
			"accepted_prediction_tokens": 0,
			"rejected_prediction_tokens": 0
		}
	},
	"system_fingerprint": "fp_9b78b61c52"
}''';

  Future<Either<MainError, List<RankingItem>>> parseResponse() async {
    final regex = RegExp(r'```json\s*(.+?)\s*```', dotAll: true);
    final match = regex.firstMatch(jsonResponse);

    if (match != null) {
      // The captured group contains the JSON content
      String jsonString = match.group(1)!;

      // Decode the extracted JSON
      List<dynamic> jsonList = jsonDecode(jsonString);

      print(jsonList);

      // Process the list into BoardGame objects
      List<RankingItem> rankingItems = jsonList
          .map((itemJson) => RankingTransformer.fromJson(itemJson))
          .toList();

      // Print the parsed games
      for (var item in rankingItems) {
        print("Ranking Item: ${item.title}, Rating: ${item.rating}");
      }
      return Right(rankingItems);
    } else {
      print("No JSON content found between ```json and ```");
      return Left(ServerError());
    }
  }

  @override
  Future<Either<MainError, List<RankingItem>>> getRanking({
    required String query,
  }) {
    return parseResponse();
  }
}
