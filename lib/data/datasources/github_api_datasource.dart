import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/errors/failures.dart';
import '../models/repository_model.dart';

class GithubApiDataSource {
  final Dio _dio;

  GithubApiDataSource({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
              baseUrl: ApiConstants.baseUrl,
              connectTimeout: ApiConstants.timeoutDuration,
              receiveTimeout: ApiConstants.timeoutDuration,
            ));

  Future<List<RepositoryModel>> searchRepositories({
    required String query,
    int page = 1,
    int perPage = ApiConstants.defaultPerPage,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.searchRepositories,
        queryParameters: {
          'q': query,
          'page': page,
          'per_page': perPage,
        },
      );

      final items = response.data['items'] as List;
      return items
          .map((item) => RepositoryModel.fromJson(item))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw const NetworkFailure('Connection timeout');
      } else if (e.type == DioExceptionType.badResponse) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 403) {
          throw const ApiFailure('API rate limit exceeded');
        } else if (statusCode == 422) {
          throw const ApiFailure('Invalid search query');
        }
        throw ApiFailure('Server error: $statusCode');
      }
      throw NetworkFailure('Network error: ${e.message}');
    } catch (e) {
      throw UnknownFailure('Unexpected error: $e');
    }
  }
}