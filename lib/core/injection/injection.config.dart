// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pathfinding/core/injection/injection.dart' as _i422;
import 'package:pathfinding/core/routing/router.dart' as _i1061;
import 'package:pathfinding/data_sources/remote.dart' as _i1050;
import 'package:pathfinding/presentation/home/bloc/home_page_bloc.dart' as _i11;
import 'package:pathfinding/repositories/fields.dart' as _i28;
import 'package:pathfinding/services/network/api.dart' as _i245;
import 'package:pathfinding/services/network/network_sevice.dart' as _i157;
import 'package:pathfinding/use_cases/save_url_and_get_fields.dart' as _i564;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i361.Dio>(() => registerModule.dio());
    gh.singleton<_i1061.AppRouter>(() => _i1061.AppRouter());
    gh.singleton<_i157.HttpClientsService>(
        () => _i157.HttpClientsServiceImpl());
    gh.factory<_i245.PathFindingApiService>(
        () => _i245.PathFindingApiService(gh<_i157.HttpClientsService>()));
    gh.factory<_i1050.FieldRemoteDataSource>(() =>
        _i1050.FieldRemoteDataSourceImpl(gh<_i245.PathFindingApiService>()));
    gh.singleton<_i28.FieldsRepository>(
        () => _i28.FieldsRepositoryImpl(gh<_i1050.FieldRemoteDataSource>()));
    gh.factory<_i564.SaveUriAndGetFields>(
        () => _i564.SaveUriAndGetFieldsImpl(gh<_i28.FieldsRepository>()));
    gh.factory<_i11.HomePageBloc>(
        () => _i11.HomePageBloc(gh<_i564.SaveUriAndGetFields>()));
    return this;
  }
}

class _$RegisterModule extends _i422.RegisterModule {}
