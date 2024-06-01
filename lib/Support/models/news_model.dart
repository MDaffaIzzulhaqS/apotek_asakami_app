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
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fshopee.co.id%2FApotek-Mini-%2528L%2529-Asakami-by-request-i.846177647.25612757149&psig=AOvVaw0cejWhPRzqgQApu3TP8kLu&ust=1716990385619000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCNCRu-O9sIYDFQAAAAAdAAAAABAE',
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
