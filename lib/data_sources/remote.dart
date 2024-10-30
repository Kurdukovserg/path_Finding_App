import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/core/failures/failure.dart';
import 'package:pathfinding/models/fields_responce.dart';
import 'package:pathfinding/services/network/api.dart';
import 'package:pathfinding/services/network/error_handlers.dart';

abstract class FieldRemoteDataSource{
  Future<Either<Failure, FieldApiResponce>> getFields(String baseUrl);
}

@Injectable(as:FieldRemoteDataSource)
class FieldRemoteDataSourceImpl implements FieldRemoteDataSource {
  FieldRemoteDataSourceImpl(this._api);
  final PathFindingApiService _api;

  @override
  Future<Either<Failure, FieldApiResponce>> getFields(String baseUrl) {
    return _api
        .getFields(path: baseUrl)
        .then(right<Failure, FieldApiResponce>)
        .onNetworkError();
  }

}