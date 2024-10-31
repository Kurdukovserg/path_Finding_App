import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:pathfinding/core/bloc/notifiable_bloc.dart';
import 'package:pathfinding/dtos/field.dart';
import 'package:pathfinding/dtos/result.dart';
import 'package:pathfinding/repositories/fields.dart';
import 'package:pathfinding/services/path_finding/path_finding_service.dart';

part 'process_page_bloc.freezed.dart';
part 'process_page_event.dart';
part 'process_page_notification.dart';
part 'process_page_state.dart';

@injectable
class ProcessPageBloc
    extends NotifiableBloc<PageEvent, PageBlocState, PageNotification> {
  ProcessPageBloc(
    this._fieldsRepository,
    this._service,
  ) : super(const InitialState()) {
    on<Init>(_onInit);
  }

  final FieldsRepository _fieldsRepository;
  List<PathfinderField>? _fields;
  final PathFindingService _service;
  final List<PathFinderResult> _results = [];

  FutureOr<void> _onInit(Init event, Emitter<PageBlocState> emit) async {
    _fields = _fieldsRepository.fields;
    _fields!.forEach(
      (field) async {
        final result = await _service.algorithm.compute(field);
        _results.add(result);
        logInfo(result.resultingPath);
      },
    );
    emit(UpdatedState());
  }
}
