part of 'process_page_bloc.dart';

@immutable
sealed class PageNotification {}

@freezed
class Computed with _$Computed implements PageNotification {
  const factory Computed(int percent) = _Computed;
}