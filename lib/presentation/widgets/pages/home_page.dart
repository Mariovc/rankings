import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ranking/domain/entities/ranking_item.dart';
import 'package:ranking/presentation/util/extension/snackbar_extension.dart';
import 'package:ranking/presentation/viewmodels/home_viewmodel.dart';
import 'package:ranking/presentation/widgets/pages/root_page.dart';

class HomePage extends RootPageStateful<HomeViewModelState, HomeViewModel> {
  const HomePage({super.key});

  @override
  RootScreenState<HomeViewModelState, HomeViewModel, HomePage> createState() =>
      _HomePageState();
}

class _HomePageState
    extends RootScreenState<HomeViewModelState, HomeViewModel, HomePage> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  void listenState(BuildContext context, HomeViewModelState state) {
    super.listenState(context, state);
    if (state is Error) {
      state.message.showMessage();
    }
  }

  @override
  Widget buildView(
    BuildContext context,
    HomeViewModelState state,
    HomeViewModel viewModel,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final List<RankingItem> items = state.items;
    final buildPodium = items.length >= 3;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'home.title'.tr(),
          style: textTheme.displayMedium?.copyWith(
            color: colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: viewModel.searchController,
              focusNode: _focusNode,
              onTapOutside: (event) => _focusNode.unfocus(),
              decoration: InputDecoration(
                hintText: 'home.search_hint'.tr(),
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: viewModel.isSearchEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _focusNode.requestFocus();
                          viewModel.clearSearch();
                        },
                      ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHigh,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12),
              ),
              textCapitalization: TextCapitalization.sentences,
              textInputAction: TextInputAction.search,
              onSubmitted: viewModel.search,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            // Add 1 for the podium
            itemCount: items.length + (buildPodium ? 1 : 0),
            itemBuilder: (context, index) {
              if (buildPodium && index == 0) {
                // Return the podium as the first item
                return _buildPodium(items.sublist(0, 3));
              } else {
                // Return the list items
                return _getItem(
                  context,
                  items[buildPodium ? index - 1 : index],
                  index,
                );
              }
            },
          ),
          if (state is Loading)
            Container(
              color: Colors.black.withOpacity(0.7),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPodium(List<RankingItem> top3) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildPodiumSpot(top3[1], 2, 120),
          const SizedBox(width: 8),
          _buildPodiumSpot(top3[0], 1, 140),
          const SizedBox(width: 8),
          _buildPodiumSpot(top3[2], 3, 100),
        ],
      ),
    );
  }

  Widget _buildPodiumSpot(RankingItem item, int rank, double height) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 70,
              height: 70,
              margin: const EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 3,
                ),
              ),
              child: _getCircularImage(item.imageUrl, size: 35),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  _getRankingEmoji(rank),
                  style: const TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 100,
          child: Text(
            item.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: height,
          width: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.surfaceContainerHigh,
              Theme.of(context).colorScheme.surfaceContainerLow,
            ]),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Center(
            child: Text(
              '$rank',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 48,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getItem(BuildContext context, RankingItem item, int rank) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => viewModel.onItemClick(item),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    '#$rank',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(height: 12),
                  _getCircularImage(item.imageUrl, size: 42),
                  if (item.rating != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: Theme.of(context).colorScheme.secondary),
                        Text(' ${item.rating!.toStringAsFixed(1)}'),
                      ],
                    ),
                  ]
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    if (item.timestamp != null || item.countryCode != null)
                      Row(
                        children: [
                          if (item.timestamp != null) ...[
                            Text(
                              DateFormat.yMMMd().format(item.timestamp!),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 8),
                          ],
                          if (item.countryCode != null)
                            Text(_getEmojiFlag(item.countryCode!)),
                        ],
                      ),
                    if (item.categories.isNotEmpty)
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: item.categories.map((category) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              category,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      item.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.6),
                          ),
                    ),
                    if (item.awards.isNotEmpty)
                      Wrap(
                        spacing: 8.0,
                        children: item.awards
                            .map(
                              (award) => Chip(
                                avatar: const Icon(
                                  Icons.emoji_events_outlined,
                                ),
                                label: Text(
                                  award,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(fontSize: 12),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getRankingEmoji(int rank) {
    switch (rank) {
      case 1:
        return '🥇';
      case 2:
        return '🥈';
      case 3:
        return '🥉';
      default:
        return '';
    }
  }

  String _getEmojiFlag(String countryCode) {
    return String.fromCharCodes(
        countryCode.codeUnits.map((c) => 0x1F1E6 - 0x41 + c));
  }

  Widget _getCircularImage(String? imageUrl, {required double size}) {
    return CircleAvatar(
      radius: size,
      backgroundImage:
          imageUrl?.isNotEmpty ?? false ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? const CircularProgressIndicator()
          : imageUrl.isEmpty
              ? Icon(
                  Icons.broken_image,
                  size: 35,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                )
              : null,
    );
  }
}
