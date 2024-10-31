part of 'process_page_bloc.dart';

@immutable
sealed class PageEvent {}

@freezed
class Init with _$Init implements PageEvent {
  const factory Init() = _Init;
}

@freezed
class SendResults with _$SendResults implements PageEvent {
  const factory SendResults() = _SendResults;
}