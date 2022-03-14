part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}

class Loading extends NewsState {
  const Loading();
}

class SearchLoading extends NewsState {
  const SearchLoading();
}

class FilterFetchLoading extends NewsState {
  const FilterFetchLoading();
}

class Loaded extends NewsState {
  const Loaded({required this.model});
  final NewsModel model;
  @override
  List<Object> get props => [model];
}

class FilterFetchLoaded extends NewsState {
  const FilterFetchLoaded({required this.model});
  final NewsModel model;
  @override
  List<Object> get props => [model];
}

class SearchLoaded extends NewsState {
  const SearchLoaded({required this.model});
  final NewsModel model;
  @override
  List<Object> get props => [model];
}

class NewsError extends NewsState {
  const NewsError({this.message});
  final String? message;
}

class SortLoading extends NewsState {
  const SortLoading();
  @override
  List<Object> get props => [];
}

class SortLoaded extends NewsState {
  const SortLoaded({required this.model});
  final NewsModel model;
  @override
  List<Object> get props => [model];
}
