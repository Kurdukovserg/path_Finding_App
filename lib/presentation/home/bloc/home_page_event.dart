part of 'home_page_bloc.dart';

@immutable
sealed class PageEvent {}

@freezed
class SaveUri with _$SaveUri implements PageEvent {
  const factory SaveUri({
    required String baseUri,
  })=_SaveUri;
}