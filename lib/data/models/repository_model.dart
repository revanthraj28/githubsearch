import 'package:github_search_app/domain/entities/repository_entity.dart';
class RepositoryModel {
  final int id;
  final String name;
  final String fullName;
  final Owner owner;
  final String? description;
  final String? language;
  final int stargazersCount;
  final int watchersCount;
  final int forksCount;
  final int openIssuesCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const RepositoryModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.owner,
    this.description,
    this.language,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    required this.openIssuesCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      fullName: json['full_name'] as String,
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      description: json['description'] as String?,
      language: json['language'] as String?,
      stargazersCount: json['stargazers_count'] as int,
      watchersCount: json['watchers_count'] as int,
      forksCount: json['forks_count'] as int,
      openIssuesCount: json['open_issues_count'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  RepositoryEntity toEntity() {
    return RepositoryEntity(
      id: id,
      name: name,
      fullName: fullName,
      ownerLogin: owner.login,
      ownerAvatarUrl: owner.avatarUrl,
      description: description,
      language: language,
      stargazersCount: stargazersCount,
      watchersCount: watchersCount,
      forksCount: forksCount,
      openIssuesCount: openIssuesCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class Owner {
  final String login;
  final String avatarUrl;

  const Owner({
    required this.login,
    required this.avatarUrl,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
    );
  }
}