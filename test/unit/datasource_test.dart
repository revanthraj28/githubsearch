import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:github_search_app/data/datasources/github_api_datasource.dart';
import 'package:github_search_app/core/errors/failures.dart';
@GenerateMocks([Dio])
import 'datasource_test.mocks.dart';

void main() {
  late GithubApiDataSource dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = GithubApiDataSource(dio: mockDio);
  });

  group('searchRepositories', () {
    test('should return list of repositories on success', () async {
      // Arrange
      const query = 'flutter';
      final responseData = {
        'items': [
          {
            'id': 1,
            'name': 'flutter',
            'full_name': 'flutter/flutter',
            'owner': {
              'login': 'flutter',
              'avatar_url': 'https://example.com/avatar.png',
            },
            'description': 'Flutter SDK',
            'language': 'Dart',
            'stargazers_count': 100000,
            'watchers_count': 5000,
            'forks_count': 20000,
            'open_issues_count': 1000,
            'created_at': '2015-03-06T22:54:58Z',
            'updated_at': '2024-10-11T00:00:00Z',
          }
        ]
      };

      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => Response(
                data: responseData,
                statusCode: 200,
                requestOptions: RequestOptions(),
              ));

      // Act
      final result = await dataSource.searchRepositories(query: query);

      // Assert
      expect(result.length, 1);
      expect(result.first.name, 'flutter');
    });

    test('should throw NetworkFailure on connection timeout', () async {
      // Arrange
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenThrow(DioException(
            type: DioExceptionType.connectionTimeout,
            requestOptions: RequestOptions(),
          ));

      // Act & Assert
      expect(
        () => dataSource.searchRepositories(query: 'flutter'),
        throwsA(isA<NetworkFailure>()),
      );
    });
  });
}