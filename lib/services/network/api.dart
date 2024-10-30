import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/models/fields_responce.dart';
import 'package:pathfinding/services/network/network_sevice.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';

part 'api.g.dart';

@injectable
@RestApi()
abstract class PathFindingApiService {
  @factoryMethod
  factory PathFindingApiService(HttpClientsService clientService) =>
      _PathFindingApiService(
        clientService.apiClient,
      );

  @GET('{path}')
  Future<FieldApiResponce> getFields({
    @Path('path') required String path,
  });
}
