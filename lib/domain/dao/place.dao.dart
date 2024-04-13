import 'package:template_flutter_but/data/network/models/place.model.dart';

abstract class PlaceDao {
  Future<void> addPlace(PlaceModel model);
  Future<PlaceModel> getPlaces();
  Future<void> updatePlace(PlaceModel updatedPlace);
}
