import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/core/failures/failure.dart';
import 'package:pathfinding/data_sources/remote.dart';
import 'package:pathfinding/dtos/field.dart';
import 'package:pathfinding/dtos/result.dart';
import 'package:pathfinding/models/results_request.dart';
import 'package:pathfinding/models/results_response.dart';
import 'package:pathfinding/services/path_finding/path_finding_service.dart';
import 'package:rxdart/rxdart.dart';

abstract class FieldsRepository {
  void reset();

  void setup(String uri);

  Future<Either<Failure, List<PathfinderField>>> getFields();

  List<PathfinderField> get fields;

  Stream<PathFinderResult> get resultsStream;

  Future<Either<Failure, ResultsApiResponce>> sendResults();

  List<PathFinderResult> get cachedResults;
}

@Singleton(as: FieldsRepository)
class FieldsRepositoryImpl implements FieldsRepository {
  FieldsRepositoryImpl(this._remote, this._service);

  final FieldRemoteDataSource _remote;
  final PathFindingService _service;
  String? baseUri;
  List<PathfinderField>? _cachedFields;
  bool shouldUpdateResultsStream = true;
  final List<PathFinderResult> _cachedResults = [];
  PathFinderResult? _cachedResultValue;

  @override
  List<PathFinderResult> get cachedResults => _cachedResults;

  PathFinderResult? get _cachedResult => _cachedResultValue;

  set _cachedResult(PathFinderResult? newResult) {
    _cachedResultValue = newResult;

    if (newResult != null) {
      _cachedResults.add(newResult);
      _resultsStreamController.add(newResult);
    }
  }

  late BehaviorSubject<PathFinderResult> _resultsStreamController =
      BehaviorSubject<PathFinderResult>(onListen: _startComputations);

  @override
  List<PathfinderField> get fields => _cachedFields ?? [];

  @override
  Future<Either<Failure, List<PathfinderField>>> getFields() async {
    final responseOrFailure = await _remote.getFields(baseUri!);
    return responseOrFailure.fold((failure) => left(failure), (response) {
      _cachedFields = response.fields;
      return right(_cachedFields!);
    });
  }

  @override
  void reset() async {
    baseUri = null;
    await _resultsStreamController.close();
    _resultsStreamController =
        BehaviorSubject<PathFinderResult>(onListen: _startComputations);
  }

  @override
  void setup(String uri) {
    baseUri = uri;
  }

  @override
  Stream<PathFinderResult> get resultsStream => _resultsStreamController.stream;

  void _startComputations() async {
    for (int i = 0; i < _cachedFields!.length; i++) {
      final result = await _service.algorithm.compute(_cachedFields![i]);
      _cachedResult = result;
    }
  }

  @override
  Future<Either<Failure, ResultsApiResponce>> sendResults() async {
    List<ResultApiRequest> results = [];
    for (int i = 0; i < _cachedResults.length; i++) {
      final result = _cachedResults[i];
      results.add(
        ResultApiRequest(
          id: result.id,
          result: Steps(
              steps: result.pathNodes!
                  .map((e) => DotModel(x: e.x, y: e.y))
                  .toList(),
              path: result.resultingPath),
        ),
      );
    }
    final resOrFailure = await _remote.sendResults(baseUri!, results);
    return resOrFailure.fold(left, (res) => right(res));
  }
}
