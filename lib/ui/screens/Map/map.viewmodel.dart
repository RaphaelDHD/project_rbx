import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter_but/application/injections/initializer.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';
import 'package:template_flutter_but/domain/repository/places.repository.dart';
import 'package:template_flutter_but/ui/abstraction/view_model_abs.dart';
import 'package:template_flutter_but/ui/screens/map/map.state.dart';

final StateNotifierProvider<MapViewModel, MapState> homeProvider =
    StateNotifierProvider<MapViewModel, MapState>(
  (StateNotifierProviderRef<MapViewModel, MapState> ref) => MapViewModel(
    placesRepository: injector<PlacesRepository>(),
  ),
);

class MapViewModel extends ViewModelAbs<MapViewModel, MapState> {
  final PlacesRepository _placesRepository;

  MapViewModel({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository,
        super(const MapState.initial()) {
    _init();
  }

  void _init() async {
    final PlaceEntity places = await _placesRepository.getPlaces();
    state = state.copyWith(places: places);
  }
  
}
