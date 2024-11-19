import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:images/domain/entities/ranking_item.dart';
import 'package:images/presentation/viewmodels/home_viewmodel.dart';
import 'package:images/presentation/widgets/pages/root_page.dart';

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
  Widget buildView(
    BuildContext context,
    HomeViewModelState state,
    HomeViewModel viewModel,
  ) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            centerTitle: true,
            title: Text('home.title'.tr()),
            forceElevated: innerBoxIsScrolled,
          ),
          SliverAppBar(
            primary: false,
            floating: true,
            snap: true,
            forceElevated: innerBoxIsScrolled,
            title: TextField(
              focusNode: _focusNode,
              onTapOutside: (event) => _focusNode.unfocus(),
              decoration: InputDecoration(
                hintText: 'home.search_hint'.tr(),
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainer,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
              textCapitalization: TextCapitalization.sentences,
              onChanged: viewModel.search,
            ),
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(8), child: SizedBox()),
          )
        ],
        body: ListView.separated(
            itemBuilder: (context, index) {
              return _getItem(context, viewModel.items[index], index);
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: viewModel.items.length),
      ),
    );
  }

  Widget _getItem(BuildContext context, RankingItem item, int index) {
    final Color primaryColor = item.dominantColor != null
        ? Color(int.parse(item.dominantColor.replaceFirst('#', '0xFF')))
        : Colors.blue;

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              '#${index + 1}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(item.imageUrl),
                        radius: 30,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              item.description,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      Text(' ${item.rating}/5'),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.location_pin,
                              color: Colors.redAccent),
                          Text(item.location,
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Text(
                          item.country,
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (item.awards.isNotEmpty)
                    Wrap(
                      spacing: 8.0,
                      children: item.awards
                          .map((award) => Chip(
                              label: Text(award,
                                  style: const TextStyle(fontSize: 12))))
                          .toList(),
                    ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: item.score / 100,
                    backgroundColor: Colors.grey[300],
                    color: primaryColor,
                    minHeight: 8,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.thumb_up, color: Colors.blueAccent),
                          const SizedBox(width: 4),
                          Text('${item.likes} Likes'),
                        ],
                      ),
                      TextButton(
                        onPressed: () => print(
                            'Open ${item.link}'), // Use url_launcher in production
                        child: const Text('More Info',
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
