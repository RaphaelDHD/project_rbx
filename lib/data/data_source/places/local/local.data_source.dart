import 'package:template_flutter_but/data/local/models/favorite.model.dart';
import 'package:template_flutter_but/data/network/models/place.model.dart';

abstract class PlacesLocalDataSource {
  Future<PlaceModel> getPlaces();
  Future<FavoriteModel> getFavorite();
}
