import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter_but/application/injections/initializer.dart';
import 'package:template_flutter_but/domain/entities/marker.entity.dart';
import 'package:template_flutter_but/domain/entities/monument.entity.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';
import 'package:template_flutter_but/domain/services/places.services.dart';
import 'package:template_flutter_but/ui/abstraction/view_model_abs.dart';
import 'package:template_flutter_but/ui/screens/map/map.state.dart';

final StateNotifierProvider<MapViewModel, MapState> mapProvider =
    StateNotifierProvider<MapViewModel, MapState>(
  (StateNotifierProviderRef<MapViewModel, MapState> ref) => MapViewModel(
    placesService: injector<PlacesService>(),
  ),
);

class MapViewModel extends ViewModelAbs<MapViewModel, MapState> {
  final PlacesService _placesService;

  MapViewModel({required PlacesService placesService})
      : _placesService = placesService,
        super(MapState.initial()) {
    _init();
  }

  void _init() async { 
    _placesService.placeValueNotifier.addListener(() {
      final List<MarkerEntity> markers = getMarkers(
          _placesService.placeValueNotifier.value ??
              const PlaceEntity(totalCount: 0, results: <MonumentEntity>[]));
      state = state.copyWith(
          places: _placesService.placeValueNotifier.value, markers: markers);
    });
    final List<MarkerEntity> markers = getMarkers(
        _placesService.placeValueNotifier.value ??
            const PlaceEntity(totalCount: 0, results: <MonumentEntity>[]));
    state = state.copyWith(
        places: _placesService.placeValueNotifier.value, markers: markers);
  }

  List<MarkerEntity> getMarkers(PlaceEntity places) {
    final List<MarkerEntity> markers = <MarkerEntity>[];
    for (final MonumentEntity place in places.results!) {
      markers.add(
        MarkerEntity(
          lat: place.lat ?? 0.0,
          long: place.long ?? 0.0,
          title: place.name ?? '',
          imageUrl: place.photo?.url ?? '',
          monumentIndex: places.results!.indexOf(place),
        ),
      );
    }
    if (kDebugMode) {
      for (MarkerEntity marker in markers) {
        print(marker.title);
      }
    }
    return markers;
  }

  void setSelectedMarker(MarkerEntity marker) {
    state = state.copyWith(selectedMarker: marker, selectedMonument: state.places!.results![marker.monumentIndex]);
  }

  void clearSelectedMarker() {
    state = state.copyWith(selectedMarker: null, selectedMonument: null);
  }


}
