import 'package:template_flutter_but/data/network/models/place.model.dart';

abstract class PlacesRemoteDataSource {
  Future<PlaceModel> getPlaces();
}
