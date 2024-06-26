class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  const Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json['source']),
      author: json['author'] ?? 'No Author',
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No Description',
      url: json['url'] ??
          'https://www.foxnews.com/world/kyiv-rocked-explosions-week-after-russian-strikes-across-ukraine',
      urlToImage: json['urlToImage'] ??
          'https://kompaspedia.kompas.id/wp-content/uploads/2020/07/logo_kemkes.png',
      publishedAt: json['publishedAt'] ?? 'No Date',
      content: json['content'] ?? 'No content',
    );
  }
}

class Source {
  final String id;
  final String name;
  const Source({required this.id, required this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json['id'] ?? '', name: json['name']);
  }
}
