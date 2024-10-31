import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/core/failures/failure.dart';
import 'package:pathfinding/core/use_case/use_case.dart';
import 'package:pathfinding/models/results_response.dart';
import 'package:pathfinding/repositories/fields.dart';

abstract class SendResultsUseCase extends UseCase<ResultsApiResponce, NoParams>{
  @override
  FutureOr<Either<Failure, ResultsApiResponce>> call([NoParams? params]);
}

@Injectable(as: SendResultsUseCase)
class SendResultsUseCaseImpl implements SendResultsUseCase{
  SendResultsUseCaseImpl(this._repository);

  final FieldsRepository _repository;

  @override
  FutureOr<Either<Failure, ResultsApiResponce>> call([NoParams? params]) {
    return _repository.sendResults();
  }

}