import 'package:injectable/injectable.dart';
import 'package:template_flutter_but/data/data_source/places/remote/remote.data_source.dart';
import 'package:template_flutter_but/data/network/endpoints/place.endpoint.dart';
import 'package:template_flutter_but/data/network/models/place.model.dart';

@Singleton(as: PlacesRemoteDataSource)
class PlacesRemoteDataSourceImpl implements PlacesRemoteDataSource {
  final PlacesEndpoint _placesEndpoint;

  PlacesRemoteDataSourceImpl({required PlacesEndpoint placesEndpoint})
      : _placesEndpoint = placesEndpoint;
  @override
  Future<PlaceModel> getPlaces() {
    return _placesEndpoint.getPlaces();
  }
}
