// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:template_flutter_but/data/data_source/places/remote/impl/remote.data_source_impl.dart'
    as _i7;
import 'package:template_flutter_but/data/data_source/places/remote/remote.data_source.dart'
    as _i6;
import 'package:template_flutter_but/data/network/endpoints/place.endpoint.dart'
    as _i5;
import 'package:template_flutter_but/data/repositories/places/places.repository_impl.dart'
    as _i9;
import 'package:template_flutter_but/domain/repository/places.repository.dart'
    as _i8;
import 'package:template_flutter_but/foundation/client/dio.client.dart' as _i3;
import 'package:template_flutter_but/foundation/client/interceptors/header.interceptor.dart'
    as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.DioClient>(() => _i3.DioClient());
    gh.singleton<_i4.HeaderInterceptor>(
        () => _i4.HeaderInterceptor(dioClient: gh<_i3.DioClient>()));
    gh.singleton<_i5.PlacesEndpoint>(
        () => _i5.PlacesEndpoint(gh<_i3.DioClient>()));
    gh.singleton<_i6.PlacesRemoteDataSource>(() =>
        _i7.PlacesRemoteDataSourceImpl(
            placesEndpoint: gh<_i5.PlacesEndpoint>()));
    gh.singleton<_i8.PlacesRepository>(() => _i9.PlacesRepositoryImpl(
        placesRemoteDataSource: gh<_i6.PlacesRemoteDataSource>()));
    return this;
  }
}
