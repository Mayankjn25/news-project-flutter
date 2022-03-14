import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_project/logic/http/http.dart';
import 'package:news_project/models/news_model.dart';
import 'package:news_project/utils/api.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial());
  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is FetchNews) {
      yield const Loading();

      final res = await Https.getMethod(
          url:
              '${Api.base}top-headlines?country=${event.country != null ? event.country : 'In'}&apiKey=${Api.apiKey}');
      final data = newsModelFromJson(res.body);
      if (data.status.contains('ok')) {
        yield Loaded(model: data);
      } else {
        yield NewsError(message: jsonDecode(res.body)['code']);
      }
    }
    if (event is FetchSearch) {
      yield const SearchLoading();
      final res = await Https.getMethod(
          url: '${Api.base}top-headlines?q=${event.search}&apiKey=${Api.apiKey}');
      final data = newsModelFromJson(res.body);
      print('Search Data ==${data.articles.length}');
      if (data.status.contains('ok')) {
        yield SearchLoaded(model: data);
      } else {
        yield NewsError(message: jsonDecode(res.body)['code']);
      }
    }

    if (event is FetchSorting) {
      yield const Loading();
      final res = await Https.getMethod(
          url: '${Api.base}top-headlines?${event.sort}&apiKey=${Api.apiKey}');
      final data = newsModelFromJson(res.body);
      print('Search Data sort==${event.sort.length}');
      if (data.status.contains('ok')) {
        yield SortLoaded(model: data);
      } else {
        yield NewsError(message: jsonDecode(res.body)['code']);
      }
    }
    if (event is FetchFiltered) {
      yield const Loading();
      final res = await Https.getMethod(
          url:
              '${Api.base}top-headlines?sources=${event.search}&apiKey=${Api.apiKey}');
      final data = newsModelFromJson(res.body);
      if (data.status.contains('ok')) {
        yield FilterFetchLoaded(model: data);
      } else {
        yield NewsError(message: jsonDecode(res.body)['code']);
      }
    }
  }
}
