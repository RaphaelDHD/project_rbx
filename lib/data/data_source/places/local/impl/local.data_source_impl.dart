import 'package:injectable/injectable.dart';
import 'package:template_flutter_but/data/data_source/places/local/local.data_source.dart';
import 'package:template_flutter_but/data/local/models/favorite.model.dart';
import 'package:template_flutter_but/data/network/models/place.model.dart';
import 'package:template_flutter_but/domain/dao/favorite.dao.dart';
import 'package:template_flutter_but/domain/dao/place.dao.dart';

@Singleton(as: PlacesLocalDataSource)
class PlacesLocalDataSourceImpl implements PlacesLocalDataSource {
  final PlaceDao _placesDao;
  final FavoriteDao _favoriteDao;

  PlacesLocalDataSourceImpl({required PlaceDao placesDao, required FavoriteDao favoriteDao})
      : _placesDao = placesDao,
        _favoriteDao = favoriteDao;

  @override
  Future<PlaceModel> getPlaces() {
    return _placesDao.getPlaces();
  }

  @override
  Future<FavoriteModel> getFavorite() {
    return _favoriteDao.getFavorite();
  }
}
