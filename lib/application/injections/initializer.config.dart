// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:template_flutter_but/data/dao/favorite.dao_impl.dart' as _i5;
import 'package:template_flutter_but/data/dao/place.dao_impl.dart' as _i7;
import 'package:template_flutter_but/data/data_source/places/local/impl/local.data_source_impl.dart'
    as _i13;
import 'package:template_flutter_but/data/data_source/places/local/local.data_source.dart'
    as _i12;
import 'package:template_flutter_but/data/data_source/places/remote/impl/remote.data_source_impl.dart'
    as _i11;
import 'package:template_flutter_but/data/data_source/places/remote/remote.data_source.dart'
    as _i10;
import 'package:template_flutter_but/data/network/endpoints/place.endpoint.dart'
    as _i9;
import 'package:template_flutter_but/data/repositories/places/places.repository_impl.dart'
    as _i15;
import 'package:template_flutter_but/domain/dao/favorite.dao.dart' as _i4;
import 'package:template_flutter_but/domain/dao/place.dao.dart' as _i6;
import 'package:template_flutter_but/domain/repository/places.repository.dart'
    as _i14;
import 'package:template_flutter_but/domain/services/places.services.dart'
    as _i16;
import 'package:template_flutter_but/foundation/client/dio.client.dart' as _i3;
import 'package:template_flutter_but/foundation/client/interceptors/header.interceptor.dart'
    as _i8;

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
    gh.singleton<_i4.FavoriteDao>(() => _i5.FavoriteDaoImpl());
    gh.singleton<_i6.PlaceDao>(() => _i7.PlaceDaoImpl());
    gh.singleton<_i8.HeaderInterceptor>(
        () => _i8.HeaderInterceptor(dioClient: gh<_i3.DioClient>()));
    gh.singleton<_i9.PlacesEndpoint>(
        () => _i9.PlacesEndpoint(gh<_i3.DioClient>()));
    gh.singleton<_i10.PlacesRemoteDataSource>(() =>
        _i11.PlacesRemoteDataSourceImpl(
            placesEndpoint: gh<_i9.PlacesEndpoint>()));
    gh.singleton<_i12.PlacesLocalDataSource>(
        () => _i13.PlacesLocalDataSourceImpl(
              placesDao: gh<_i6.PlaceDao>(),
              favoriteDao: gh<_i4.FavoriteDao>(),
            ));
    gh.singleton<_i14.PlacesRepository>(() => _i15.PlacesRepositoryImpl(
          placesRemoteDataSource: gh<_i10.PlacesRemoteDataSource>(),
          placesLocalDataSource: gh<_i12.PlacesLocalDataSource>(),
          favoriteDao: gh<_i4.FavoriteDao>(),
          placesDao: gh<_i6.PlaceDao>(),
        ));
    gh.singleton<_i16.PlacesService>(() =>
        _i16.PlacesService(placesRepository: gh<_i14.PlacesRepository>()));
    return this;
  }
}
