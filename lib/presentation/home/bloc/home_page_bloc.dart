import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/core/bloc/notifiable_bloc.dart';
import 'package:pathfinding/dtos/field_dot.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';
part 'home_page_notification.dart';
part 'home_page_bloc.freezed.dart';

@injectable
class HomePageBloc extends NotifiableBloc<PageEvent, PageBlocState, PageNotification>{
  HomePageBloc(): super(const UpdatedState()){
    on<SaveUri>(_onSaveUri);
  }


  FutureOr<void> _onSaveUri(SaveUri event, Emitter<PageBlocState> emit) {
    emit(UpdatedState());
  }
}