import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/core/bloc/notifiable_bloc.dart';


part 'results_page_bloc.freezed.dart';
part 'results_page_event.dart';
part 'results_page_notification.dart';
part 'results_page_state.dart';

@injectable
class ResultsPageBloc
    extends NotifiableBloc<PageEvent, PageBlocState, PageNotification> {
  ResultsPageBloc() : super(const UpdatedState()) {
    on<Init>(_onInit);
  }



  FutureOr<void> _onInit(Init event, Emitter<PageBlocState> emit) {
  }
}
