import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ranking/core/di/injection.dart';
import 'package:ranking/presentation/viewmodels/root_viewmodel.dart';

abstract class RootPage<S extends ViewState, V extends RootViewModel<S>>
    extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = getIt<V>();

    return BlocBuilder<V, S>(
      bloc: viewModel,
      builder: (context, state) {
        return buildView(context, state, viewModel);
      },
    );
  }

  Widget buildView(BuildContext context, S state, V viewModel);
}

abstract class RootPageStateful<T extends ViewState, V extends RootViewModel<T>>
    extends StatefulWidget {
  const RootPageStateful({super.key});

  @override
  RootScreenState<T, V, RootPageStateful<T, V>> createState();
}

abstract class RootScreenState<S extends ViewState, V extends RootViewModel<S>,
    K extends RootPageStateful<S, V>> extends State<K> {
  late final V viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = getIt<V>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<V, S>(
      bloc: viewModel,
      builder: (context, state) {
        return buildView(context, state, viewModel);
      },
      listener: listenState,
    );
  }

  Widget buildView(BuildContext context, S state, V viewModel);

  void listenState(BuildContext context, S state) {}
}
