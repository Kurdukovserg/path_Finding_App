import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/core/bloc/notifiable_bloc.dart';
import 'package:pathfinding/dtos/field.dart';
import 'package:pathfinding/use_cases/save_url_and_get_fields.dart';

part 'home_page_bloc.freezed.dart';
part 'home_page_event.dart';
part 'home_page_notification.dart';
part 'home_page_state.dart';

@injectable
class HomePageBloc
    extends NotifiableBloc<PageEvent, PageBlocState, PageNotification> {
  HomePageBloc(this._saveUriAndGetFields) : super(const UpdatedState()) {
    on<SaveUri>(_onSaveUri);
  }

  final SaveUriAndGetFields _saveUriAndGetFields;

  FutureOr<void> _onSaveUri(SaveUri event, Emitter<PageBlocState> emit) async {
    emit(LoadingState());
    final fieldsOrFailure = await _saveUriAndGetFields.call(event.baseUri);
    fieldsOrFailure.fold((failure) => emit(ErrorState(failure.toString())), (fields) {
      final fieldDtoList = fields.map((e) => e.toDto()).toList();
      emitNotification(FieldsFetchedNotification(fields: fieldDtoList));
      emit(UpdatedState());
    });

  }
}
