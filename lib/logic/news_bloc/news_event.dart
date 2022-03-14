part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class FetchNews extends NewsEvent {
  const FetchNews({this.country});
  final String? country;
  @override
  List<Object?> get props => [country];
}

class FetchSearch extends NewsEvent {
  const FetchSearch({required this.search});
  final String search;
  @override
  List<Object?> get props => [search];
}

class FetchFiltered extends NewsEvent {
  const FetchFiltered({required this.search});
  final String search;
  @override
  List<Object?> get props => [search];
}

class FetchSorting extends NewsEvent {
  const FetchSorting({required this.sort});
  final String sort;
  @override
  List<Object?> get props => [sort];
}
