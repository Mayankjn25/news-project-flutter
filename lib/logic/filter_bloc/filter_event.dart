part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
}

class FetchFilter extends FilterEvent {
  const FetchFilter({required this.country});
  final String country;
  @override
  List<Object?> get props => [country];
}