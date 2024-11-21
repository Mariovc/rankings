import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:either_dart/either.dart';
import 'package:ranking/domain/entities/ranking_item.dart';
import 'package:ranking/domain/usecases/get_default_ranking_search_usecase.dart';
import 'package:ranking/domain/usecases/get_image_url_usecase.dart';
import 'package:ranking/domain/usecases/get_ranking_usecase.dart';
import 'package:ranking/presentation/util/error_extension.dart';
import 'package:ranking/presentation/viewmodels/root_viewmodel.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

@Injectable()
class HomeViewModel extends RootViewModel<HomeViewModelState> {
  final Logger logger;
  final GetRankingUseCase _getImagesUseCase;
  final GetDefaultRankingSearchUseCase _getDefaultRankingSearchUseCase;
  final GetImageUrlUseCase _getImageUrlUseCase;

  String _query = '';
  List<RankingItem> _items = [];
  final StreamController<List<RankingItem>> _itemsStream = StreamController();

  final searchController = TextEditingController();
  bool get isSearchEmpty => searchController.text.isEmpty;
  Stream<List<RankingItem>> get itemsStream => _itemsStream.stream;

  HomeViewModel(
    this.logger,
    this._getImagesUseCase,
    this._getDefaultRankingSearchUseCase,
    this._getImageUrlUseCase,
  ) : super(Success()) {
    _setSeachQuery();
    _loadItems();
  }

  void dispose() {
    _itemsStream.close();
    searchController.dispose();
  }

  void _setSeachQuery() {
    _getDefaultRankingSearchUseCase().then(
      (result) => searchController.text = result.isRight ? result.right : '',
    );
  }

  Future<void> _loadItems([String? query]) async {
    emitValue(Loading());
    _query = query ?? '';
    final result = await _getImagesUseCase(
      query: _query,
    );
    result.fold(
      (error) => emitValue(Error(error.message)),
      (newItems) {
        _items = newItems;
        _itemsStream.add(newItems);
        _fetchImages(_query, newItems);
        emitValue(Success());
      },
    );
  }

  void search(String value) {
    if (value.isNotEmpty) _loadItems(value);
  }

  void clearSearch() {
    _query = '';
    searchController.clear();
  }

  void onItemClick(RankingItem item) {
    _launchUrl(item.link);
  }

  void _launchUrl(String? url) async {
    if (url == null || url.isEmpty) {
      _emitInvalidUrl();
    } else {
      try {
        final Uri uri = Uri.parse(url);
        if (!await launchUrl(uri)) {
          // if the URL was NOT launched successfully
          _emitInvalidUrl();
        }
      } on FormatException catch (e) {
        logger.e(e.message, error: e);
        // Handle FormatException
        _emitInvalidUrl();
      } on PlatformException catch (e) {
        logger.e(e.message, error: e);
        // Handle PlatformException
        _emitInvalidUrl();
      }
    }
  }

  void _emitInvalidUrl() {
    emitValue(Error('home.invalid_url'.tr()));
  }

  void _fetchImages(String rankingQuery, List<RankingItem> newItems) {
    for (final item in newItems) {
      if (item.imageUrl != null) continue;
      final imageResult = _getImageUrlUseCase(
        rankingQuery: rankingQuery,
        query: item.title,
      );
      imageResult.fold(
        (error) => _setImageUrl(item, ''),
        (url) => _setImageUrl(item, url),
      );
    }
  }

  void _setImageUrl(RankingItem item, String url) {
    logger.i('Image URL: $url');
    final index = _items.indexWhere((element) => element.title == item.title);
    if (index != -1) {
      _items[index] = item.copyWith(imageUrl: url);
      _itemsStream.add(_items);
    }
  }
}

sealed class HomeViewModelState extends ViewState {
  const HomeViewModelState();
}

class Loading extends HomeViewModelState {
  Loading();
}

class Error extends HomeViewModelState {
  final String message;

  Error(this.message);
}

class Success extends HomeViewModelState {
  Success();
}
