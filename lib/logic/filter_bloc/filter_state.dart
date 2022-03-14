part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();
  @override
  List<Object> get props => [];
}

class FilterInitial extends FilterState {
  @override
  List<Object> get props => [];
}

class FilterLoaded extends FilterState {
  const FilterLoaded({required this.model});
  final FilterModel model;
  @override
  List<Object> get props => [model];
}

class FilterError extends FilterState {
  const FilterError({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class FilterLoading extends FilterState {
  const FilterLoading();
}
