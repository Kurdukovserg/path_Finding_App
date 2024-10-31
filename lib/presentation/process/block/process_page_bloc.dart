import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/core/bloc/notifiable_bloc.dart';
import 'package:pathfinding/dtos/field.dart';
import 'package:pathfinding/dtos/result.dart';
import 'package:pathfinding/repositories/fields.dart';

part 'process_page_bloc.freezed.dart';
part 'process_page_event.dart';
part 'process_page_notification.dart';
part 'process_page_state.dart';

@injectable
class ProcessPageBloc
    extends NotifiableBloc<PageEvent, PageBlocState, PageNotification> {
  ProcessPageBloc(
    this._fieldsRepository,
  ) : super(const InitialState()) {
    on<Init>(_onInit);
  }

  final FieldsRepository _fieldsRepository;
  List<PathfinderField>? _fields;
  final List<PathFinderResult> _results = [];
  bool calculationsFinished = false;

  FutureOr<void> _onInit(Init event, Emitter<PageBlocState> emit) async {
    _fields = _fieldsRepository.fields;
    registerStream(_fieldsRepository.resultsStream, (res) {
      _results.add(res);
      if (_fields!.length == _results.length) {
        calculationsFinished = true;
      } else if (!calculationsFinished) {
        return LoadingState((_fields!.length / _results.length).clamp(0, 1.0));
      }
      return UpdatedState();
    });
  }
}
