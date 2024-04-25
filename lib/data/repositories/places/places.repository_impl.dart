import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:template_flutter_but/data/data_source/places/local/local.data_source.dart';
import 'package:template_flutter_but/data/data_source/places/remote/remote.data_source.dart';
import 'package:template_flutter_but/data/local/models/favorite.model.dart';
import 'package:template_flutter_but/data/network/models/place.model.dart';
import 'package:template_flutter_but/domain/dao/favorite.dao.dart';
import 'package:template_flutter_but/domain/dao/place.dao.dart';
import 'package:template_flutter_but/domain/entities/favortie.entity.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';
import 'package:template_flutter_but/domain/repository/places.repository.dart';

@Singleton(as: PlacesRepository)
class PlacesRepositoryImpl implements PlacesRepository {
  final PlacesRemoteDataSource _placesRemoteDataSource;
  final PlacesLocalDataSource _placesLocalDataSource;
  final FavoriteDao _favoriteDao;
  final PlaceDao _placesDao;

  PlacesRepositoryImpl(
      {required PlacesRemoteDataSource placesRemoteDataSource,
      required PlacesLocalDataSource placesLocalDataSource,
      required FavoriteDao favoriteDao,
      required PlaceDao placesDao})
      : _placesRemoteDataSource = placesRemoteDataSource,
        _placesLocalDataSource = placesLocalDataSource,
        _favoriteDao = favoriteDao,
        _placesDao = placesDao;

  @override
  Future<PlaceEntity> getPlaces() async {
    // check if there is an internet connection
    // if there is, get data from remote data source
    // if there is not, get data from local data source
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      final PlaceModel model = await _placesLocalDataSource.getPlaces();
      return model.toEntity;
    }
    final PlaceModel model = await _placesRemoteDataSource.getPlaces();
    savePlaces(model);
    return model.toEntity;
  }

  @override
  Future<PlaceEntity> getPlacesWithOffset({required int offset}) async {
    final PlaceModel model =
        await _placesRemoteDataSource.getPlacesWithOffset(offset: offset);
    return model.toEntity;
  }

  @override
  Future<FavoriteEntity> getFavorite() async {
    final FavoriteModel model = await _placesLocalDataSource.getFavorite();
    return model.toEntity;
  }

  @override
  void addToFavorite({required int id}) {
    _favoriteDao.addToFavorite(favoriteId: id);
  }

  @override
  void removeFromFavorite({required int id}) {
    _favoriteDao.removeFromFavorite(favoriteId: id);
  }

  @override
  void savePlaces(PlaceModel model) {
    _placesDao.updatePlace(model);
  }
}
