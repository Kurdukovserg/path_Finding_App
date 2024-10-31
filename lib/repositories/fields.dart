import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/core/failures/failure.dart';
import 'package:pathfinding/data_sources/remote.dart';
import 'package:pathfinding/dtos/field.dart';

abstract class FieldsRepository{
  void reset();
  void setup(String uri);
  Future<Either<Failure, List<PathfinderField>>> getFields();
  List<PathfinderField> get fields;

}

@Singleton(as: FieldsRepository)
class FieldsRepositoryImpl implements FieldsRepository{
  FieldsRepositoryImpl(this._remote);

  final FieldRemoteDataSource _remote;
  String? baseUri;
  List<PathfinderField>? _cachedFields;

  @override
  List<PathfinderField> get fields => _cachedFields??[];

  @override
  Future<Either<Failure, List<PathfinderField>>> getFields() async {
    final responseOrFailure = await _remote.getFields(baseUri!);
    return responseOrFailure.fold((failure) => left(failure), (response) {
      _cachedFields = response.fields;
      return right(_cachedFields!);
    });
  }

  @override
  void reset() {
    baseUri = null;
  }

  @override
  void setup(String uri) {
    baseUri = uri;
  }


}