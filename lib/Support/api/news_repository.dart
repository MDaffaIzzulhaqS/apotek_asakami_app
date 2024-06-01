import 'package:apotek_asakami_app/Support/models/news_model.dart';

enum Category { health, general }

abstract class NewsRepository {
  Future<List<Article>> fetchAllNews();
  Future<List<Article>> fetchCategory(Category category);
}
