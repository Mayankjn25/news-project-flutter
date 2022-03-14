import 'package:flutter/material.dart';
import 'package:news_project/models/news_model.dart';
import 'package:news_project/screens/news_detail_screen.dart';

class NewsCard extends StatelessWidget {
  final Article news;
  const NewsCard({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = news.publishedAt;

    final String title = news.title;
    final String imageUrl = news.urlToImage;
    final String newsSource = news.source.name;
    final DateTime publishedAt = news.publishedAt;
    final int timeInHrs = DateTime.now().difference(publishedAt).inHours;
    final int timeInDays = DateTime.now().difference(publishedAt).inDays;
    final int timeInMins = DateTime.now().difference(publishedAt).inMinutes;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewsDetailScreen(
              news: news,
            ),
          ),
        );
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsSource,
                      style: const TextStyle(
                          fontFamily: 'helve',
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 4, bottom: 4, right: 4),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'helve',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      timeInMins <= 60
                          ? timeInMins.toString() + 'mins ago'
                          : timeInHrs <= 24
                              ? timeInHrs.toString() + 'hrs ago'
                              : timeInDays.toString() + 'days ago',
                      style: const TextStyle(
                        fontFamily: 'helve',
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 140,
              ),
            )
          ],
        ),
      ),
    );
  }
}