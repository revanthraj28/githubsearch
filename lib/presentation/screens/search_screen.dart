import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/search_provider.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/repository_list_item.dart';
import '../widgets/error_widget.dart' as app;
import '../widgets/animated_app_logo.dart';
import 'repository_detail_screen.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(searchNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AnimatedAppLogo(size: 32),
            const SizedBox(width: 12),
            const Text('GitHub Search'),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SearchBarWidget(
            onSearch: (query) {
              ref.read(searchQueryProvider.notifier).state = query;
              ref.read(searchNotifierProvider.notifier).search(query);
            },
          ),
          Expanded(
            child: searchResults.when(
              data: (repositories) {
                if (repositories.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AnimatedAppLogo(size: 80),
                        const SizedBox(height: 20),
                        Text(
                          'Search for repositories',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Enter a keyword to get started',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return AnimatedList(
                  key: GlobalKey<AnimatedListState>(),
                  initialItemCount: repositories.length,
                  itemBuilder: (context, index, animation) {
                    final repository = repositories[index];
                    return SizeTransition(
                      sizeFactor: animation,
                      child: FadeTransition(
                        opacity: animation,
                        child: RepositoryListItem(
                          repository: repository,
                          index: index,
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) =>
                                    RepositoryDetailScreen(repository: repository),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  
                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  
                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    Text(
                      'Searching repositories...',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              error: (error, stack) => app.ErrorWidget(
                error: error.toString(),
                onRetry: () {
                  final query = ref.read(searchQueryProvider);
                  ref.read(searchNotifierProvider.notifier).search(query);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}