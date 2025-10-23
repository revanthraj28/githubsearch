import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/github_api_datasource.dart';
import '../../domain/entities/repository_entity.dart';

final githubApiDataSourceProvider = Provider((ref) => GithubApiDataSource());

final searchQueryProvider = StateProvider<String>((ref) => '');

class SearchNotifier extends StateNotifier<AsyncValue<List<RepositoryEntity>>> {
  final GithubApiDataSource _dataSource;
  
  SearchNotifier(this._dataSource) : super(const AsyncValue.data([]));
  
  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }
    
    state = const AsyncValue.loading();
    
    try {
      final models = await _dataSource.searchRepositories(query: query);
      final entities = models.map((model) => model.toEntity()).toList();
      state = AsyncValue.data(entities);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final searchNotifierProvider = 
    StateNotifierProvider<SearchNotifier, AsyncValue<List<RepositoryEntity>>>((ref) {
  return SearchNotifier(ref.read(githubApiDataSourceProvider));
});