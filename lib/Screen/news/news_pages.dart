import 'package:apotek_asakami_app/Screen/news/news_detail_pages.dart';
import 'package:apotek_asakami_app/Support/api/news_api.dart';
import 'package:apotek_asakami_app/Support/api/news_repository.dart';
import 'package:apotek_asakami_app/Support/models/news.dart';
import 'package:apotek_asakami_app/Widget/image_container.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final api = NewsApi();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        body: TabBarView(
          children: [
            FetchNews(
              future: api.fetchCategory(Category.health),
            ),
          ],
        ),
      ),
    );
  }

  Tab tabDetail(BuildContext context, String text) {
    return Tab(
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class FetchNews extends StatelessWidget {
  const FetchNews({super.key, required this.future});
  final Future<List<Article>> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final news = snapshot.data;
          return Scaffold(
            body: ListView.builder(
              itemCount: news!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailPage(article: news[index],),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      ImageContainer(
                        width: 120,
                        height: 120,
                        margin: const EdgeInsets.all(10.0),
                        borderRadius: 5,
                        imageUrl: news[index].urlToImage,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              news[index].title,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold,),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.source, size: 18),
                                const SizedBox(width: 5),
                                Text(
                                  news[index].source.name,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 20),
                                const Icon(Icons.person, size: 18),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    news[index].author,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
