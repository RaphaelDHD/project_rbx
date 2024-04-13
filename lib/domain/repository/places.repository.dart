import 'package:template_flutter_but/data/network/models/place.model.dart';
import 'package:template_flutter_but/domain/entities/favortie.entity.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';

abstract class PlacesRepository {
  Future<PlaceEntity> getPlaces();
  Future<PlaceEntity> getPlacesWithOffset({required int offset});

  Future<FavoriteEntity> getFavorite();

  void addToFavorite({required int id});
  void removeFromFavorite({required int id});
  void savePlaces(PlaceModel model);
}
