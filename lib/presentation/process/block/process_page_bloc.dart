import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/core/bloc/notifiable_bloc.dart';
import 'package:pathfinding/dtos/field.dart';
import 'package:pathfinding/dtos/result.dart';
import 'package:pathfinding/repositories/fields.dart';
import 'package:pathfinding/use_cases/send_results.dart';

part 'process_page_bloc.freezed.dart';

part 'process_page_event.dart';

part 'process_page_notification.dart';

part 'process_page_state.dart';

@injectable
class ProcessPageBloc
    extends NotifiableBloc<PageEvent, PageBlocState, PageNotification> {
  ProcessPageBloc(
    this._fieldsRepository,
    this._sendResults,
  ) : super(const InitialState()) {
    on<Init>(_onInit);
    on<SendResults>(_onSendResults);
  }

  final FieldsRepository _fieldsRepository;
  final SendResultsUseCase _sendResults;

  List<PathfinderField>? _fields;
  final List<PathFinderResult> _results = [];
  bool _calculationsFinished = false;
  String? _error;
  bool _isButtonEnabled = true;
  bool _isResultSent = false;

  UpdatedState get _updatedState => UpdatedState(
        resultSent: _isResultSent,
        sendButtonEnabled: _isButtonEnabled,
        errorMessage: _error,
      );

  FutureOr<void> _onInit(Init event, Emitter<PageBlocState> emit) async {
    _fields = _fieldsRepository.fields;
    registerStream(_fieldsRepository.resultsStream, (res) {
      _results.add(res);
      if (_fields!.length == _results.length) {
        _calculationsFinished = true;
      } else if (!_calculationsFinished) {
        return LoadingState((_fields!.length / _results.length).clamp(0, 1.0));
      }
      return _updatedState;
    });
  }

  FutureOr<void> _onSendResults(
      SendResults event, Emitter<PageBlocState> emit) async {
    _isButtonEnabled = false;
    _isResultSent = false;
    _error = null;
    emit(_updatedState);
    final sendResultsOrFailure = await _sendResults.call();
    sendResultsOrFailure.fold((failure) {
      _isResultSent = false;
      _isButtonEnabled = true;
      _error = failure.toString();
      emit(_updatedState);
    }, (_) {
      _isResultSent = true;
      _error = null;
      _isButtonEnabled = false;
      emit(_updatedState);
      emitNotification(ResultsSent());
    });
  }
}
