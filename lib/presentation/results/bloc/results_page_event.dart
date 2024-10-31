part of 'results_page_bloc.dart';

@immutable
sealed class PageEvent {}

@freezed
class Init with _$Init implements PageEvent {
  const factory Init()=_Init;
}

@freezed
class OpenDetails with _$OpenDetails implements PageEvent {
  const factory OpenDetails({required String id})=_OpenDetails;
}