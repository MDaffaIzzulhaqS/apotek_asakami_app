import 'dart:convert';

import 'package:apotek_asakami_app/Support/models/news_model.dart';
import 'package:http/http.dart' as http;

import 'news_repository.dart';

class NewsApi extends NewsRepository {
  final keyApi = '8d2978e643904a2eab13ec6a64274e5e';

  @override
  Future<List<Article>> fetchAllNews() async {
    final url =
        'https://newsapi.org/v2/top-headlines?country=id&apiKey=$keyApi';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final json = body['articles']!;

      return json.map<Article>((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception(
          'Status Code: ${response.statusCode} Body: ${response.body}');
    }
  }

  @override
  Future<List<Article>> fetchCategory(Category category) async {
    final url =
        'https://newsapi.org/v2/top-headlines?country=id&category=${category.name}&apiKey=$keyApi';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final json = body['articles']!;
      return json.map<Article>((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception(
          'Status Code: ${response.statusCode} Body: ${response.body}');
    }
  }
}
