import 'package:http/http.dart' as http;
import 'dart:convert';


class GithubApi {

  Future<List<Repository>> searchRepositories(String query) async {
    final response = await http.get("https://api.github.com/search/repositories?q=$query");
    final body = json.decode(response.body);
    final items = body['items'];
    final repositories = items
      .map((element) => Repository.fromJson(element))
      .toList()
      .cast<Repository>();
    return repositories;
  }

}


class Repository {
  final int id;
  final String fullName;
  final String description;
  final int stargazerCount;
  final int watchersCount;
  final String language;
  final String avatarUrl;


  Repository({this.id, this.fullName, this.description, this.stargazerCount,
    this.watchersCount, this.language, this.avatarUrl});

  factory Repository.fromJson(Map<String, dynamic> json) => Repository(
    id: json['id'],
    fullName: json['full_name'],
    description: json['description'],
    stargazerCount: json['stargazers_count'],
    watchersCount: json['watchers_count'],
    language: json['language'],
    avatarUrl: json['owner']['avatar_url']
  );
}
