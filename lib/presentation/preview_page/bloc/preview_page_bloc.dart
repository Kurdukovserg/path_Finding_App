import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/core/bloc/notifiable_bloc.dart';


part 'preview_page_bloc.freezed.dart';
part 'preview_page_event.dart';
part 'preview_page_notification.dart';
part 'preview_page_state.dart';

@injectable
class PreviewPageBloc
    extends NotifiableBloc<PageEvent, PageBlocState, PageNotification> {
  PreviewPageBloc() : super(const UpdatedState()) {
    on<Init>(_onInit);
  }



  FutureOr<void> _onInit(Init event, Emitter<PageBlocState> emit) {
  }
}
