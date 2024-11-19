import 'dart:async';

import 'package:images/domain/entities/ranking_item.dart';
import 'package:images/domain/usecases/get_ranking_usecase.dart';
import 'package:images/presentation/util/error_extension.dart';
import 'package:images/presentation/viewmodels/root_viewmodel.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class HomeViewModel extends RootViewModel<HomeViewModelState> {
  static const _searchDelay = 500;

  final GetRankingUseCase _getImagesUseCase;

  String _query = '';
  Timer? _debounce;
  final List<RankingItem> _items = [];

  List<RankingItem> get items => _items;

  HomeViewModel(
    this._getImagesUseCase,
  ) : super(const Success()) {
    loadItems();
  }

  Future<void> loadItems([String? query]) async {
    emitValue(const Loading());
    _query = query ?? '';
    final result = await _getImagesUseCase(
      query: _query,
    );
    result.fold(
      (error) => emitValue(Error(error.message)),
      (newItems) {
        _items.clear();
        items.addAll(newItems);
        emitValue(const Success());
      },
    );
  }

  void search(String value) {
    if (value.isNotEmpty) _delayedSearch(value);
  }

  void _delayedSearch(String query) {
    // Cancel any existing timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Start a new timer
    _debounce = Timer(const Duration(milliseconds: _searchDelay), () {
      // Perform the search operation
      loadItems(query);
    });
  }

  void onItemClick(RankingItem item) {
    // TODO: Implement navigation
  }
}

sealed class HomeViewModelState extends ViewState {
  const HomeViewModelState();
}

class Loading extends HomeViewModelState {
  const Loading();
}

class Error extends HomeViewModelState {
  final String message;

  const Error(this.message);
}

class Success extends HomeViewModelState {
  const Success();
}
