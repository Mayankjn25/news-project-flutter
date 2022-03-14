import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_project/logic/http/http.dart';
import 'package:news_project/models/filter_model.dart';
import 'package:news_project/utils/api.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial());
  @override
  Stream<FilterState> mapEventToState(FilterEvent event) async* {
    if (event is FetchFilter) {
      yield FilterLoading();
      print('cCOuntry code  ${event.country}');
      final res = await Https.getMethod(
          url:
              '${Api.base}top-headlines/sources?country=${event.country}&&apiKey=${Api.apiKey}');
      final data = filterModelFromJson(res.body);
      print('GEt Filteres  =-== $data');
      if (data.status.contains('ok')) {
        yield FilterLoaded(model: data);
      } else {
        yield FilterError(message: jsonDecode(res.body)['code']);
      }
    }
  }
}