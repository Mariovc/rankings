import 'package:flutter_bloc/flutter_bloc.dart';

abstract class RootViewModel<T extends ViewState> extends Cubit<T> {
  RootViewModel(super.initialState);

  void emitValue(T state) {
    super.emit(state);
  }
}

abstract class ViewState {
  const ViewState();
}
