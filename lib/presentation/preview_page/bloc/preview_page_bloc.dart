import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/core/bloc/notifiable_bloc.dart';
import 'package:pathfinding/dtos/field.dart';
import 'package:pathfinding/dtos/result.dart';
import 'package:pathfinding/repositories/fields.dart';

part 'preview_page_bloc.freezed.dart';
part 'preview_page_event.dart';
part 'preview_page_notification.dart';
part 'preview_page_state.dart';

@injectable
class PreviewPageBloc
    extends NotifiableBloc<PageEvent, PageBlocState, PageNotification> {
  PreviewPageBloc(this._repository) : super(const LoadingState()) {
    on<Init>(_onInit);
  }

  final FieldsRepository _repository;

  PathFinderResult? _result;
  PathfinderField? _field;

  UpdatedState get _updatedState => UpdatedState(
        result: _result!,
        field: _field!,
      );

  FutureOr<void> _onInit(Init event, Emitter<PageBlocState> emit) {
    emit(LoadingState());

    _field = _repository.fields.firstWhere((field) => (field.id == event.id));
    _result =
        _repository.cachedResults.firstWhere((field) => (field.id == event.id));

    emit(_updatedState);
  }
}
