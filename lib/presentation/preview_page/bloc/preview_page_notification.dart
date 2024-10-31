part of 'preview_page_bloc.dart';

@immutable
sealed class PageNotification {}

@freezed
class OpenDetailsNotification with _$OpenDetailsNotification implements PageNotification {
  const factory OpenDetailsNotification({
    required String id,
  }) = _OpenDetailsNotification;
}
