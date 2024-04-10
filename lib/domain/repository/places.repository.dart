import 'package:template_flutter_but/domain/entities/place.entity.dart';

abstract class PlacesRepository {
  Future<PlaceEntity> getPlaces();
  Future<PlaceEntity> getPlacesWithOffset({required int offset});
}
