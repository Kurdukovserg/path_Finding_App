import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/core/bloc/notifiable_bloc.dart';
import 'package:pathfinding/dtos/result.dart';
import 'package:pathfinding/repositories/fields.dart';


part 'results_page_bloc.freezed.dart';
part 'results_page_event.dart';
part 'results_page_notification.dart';
part 'results_page_state.dart';

@injectable
class ResultsPageBloc
    extends NotifiableBloc<PageEvent, PageBlocState, PageNotification> {
  ResultsPageBloc(this._repository) : super(const LoadingState()) {
    on<Init>(_onInit);
  }

  final FieldsRepository _repository;


  FutureOr<void> _onInit(Init event, Emitter<PageBlocState> emit) {
    final resultList =  _repository.cachedResults;
    emit(UpdatedState(results: resultList));
  }
}
