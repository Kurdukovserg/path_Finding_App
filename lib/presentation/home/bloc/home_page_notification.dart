part of 'home_page_bloc.dart';

@immutable
sealed class PageNotification {}

@freezed
class FieldsFetchedNotification
    with _$FieldsFetchedNotification
    implements PageNotification {
  const factory FieldsFetchedNotification({
    required List<PathfinderField> fields,
  }) = _FieldsFetchedNotification;
}
