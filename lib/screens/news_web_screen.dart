// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:my_news/models/news_model.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// I added this screen to show the full news article in app web view but to use webview_flutter, min sdk 
// version should be 19 but it is required to have the min sdk version to be 16.
// So, I comment out this screen just for the reference.

// class NewsWebScreen extends StatefulWidget {
//   final NewsModel news;
//   const NewsWebScreen({Key? key, required this.news}) : super(key: key);

//   @override
//   State<NewsWebScreen> createState() => _NewsWebScreenState();
// }

// class _NewsWebScreenState extends State<NewsWebScreen> {
//   final Completer<WebViewController> _completer =
//       Completer<WebViewController>();
//   @override
//   Widget build(BuildContext context) {
//     final String url = widget.news.url;
//     return Scaffold(
//       appBar: AppBar(),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: WebView(
//           initialUrl: url,
//           onWebViewCreated: ((WebViewController webViewController) {
//             _completer.complete(webViewController);
//           }),
//         ),
//       ),
//     );
//   }
// }
