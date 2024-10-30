import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/core/failures/failure.dart';
import 'package:pathfinding/core/use_case/use_case.dart';
import 'package:pathfinding/dtos/field.dart';
import 'package:pathfinding/repositories/fields.dart';

abstract class SaveUriAndGetFields
    implements UseCase<List<PathfinderField>, String> {
  @override
  FutureOr<Either<Failure, List<PathfinderField>>> call(String params);
}

@Injectable(as: SaveUriAndGetFields)
class SaveUriAndGetFieldsImpl implements SaveUriAndGetFields {
  SaveUriAndGetFieldsImpl(this._repository);

  final FieldsRepository _repository;

  @override
  FutureOr<Either<Failure, List<PathfinderField>>> call(String params) async {
    _repository.setup(params);
    return await _repository.getFields();
  }
}
