import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_project/models/news_model.dart';
import 'package:news_project/utils/const.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({required this.news, Key? key}) : super(key: key);
  final Article news;
  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final String imageUrl = widget.news.urlToImage;
    final String title = widget.news.title;
    final String newsSource = widget.news.source.name;
    final DateTime publishedAt = widget.news.publishedAt;
    final String description = widget.news.description;
    final String date = DateFormat('yMEd').format(publishedAt);
    final String time = DateFormat('jm').format(publishedAt);

    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Const.color,
        // elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, bottom: 10, right: 10),
                          color: const Color(0x33FFFFFF),
                          child: Text(
                            title,
                            style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'helve',
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 20),
                    child: Text(
                      newsSource,
                      style: const TextStyle(
                          fontFamily: 'helve',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                    ),
                    child: Text(
                      date + ' at ' + time,
                      style: const TextStyle(
                          fontFamily: 'helve', color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 12,
                    ),
                    child: Text(
                      description,
                      style: const TextStyle(fontFamily: 'helve', fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 8,
                    ),
                    child: TextButton(
                      child: const Text('See full story >'),
                      onPressed: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         NewsWebScreen(news: widget.news),
                        //   ),
                        // );
                      },
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}