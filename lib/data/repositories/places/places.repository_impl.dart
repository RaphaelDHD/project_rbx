import 'package:injectable/injectable.dart';
import 'package:template_flutter_but/data/data_source/places/remote/remote.data_source.dart';
import 'package:template_flutter_but/data/network/models/place.model.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';
import 'package:template_flutter_but/domain/repository/places.repository.dart';

@Singleton(as: PlacesRepository)
class PlacesRepositoryImpl implements PlacesRepository {
  final PlacesRemoteDataSource _placesRemoteDataSource;

  PlacesRepositoryImpl({required PlacesRemoteDataSource placesRemoteDataSource})
      : _placesRemoteDataSource = placesRemoteDataSource;

  @override
  Future<PlaceEntity> getPlaces() async {
    final PlaceModel model = await _placesRemoteDataSource.getPlaces();
    return model.toEntity;
  }
}
