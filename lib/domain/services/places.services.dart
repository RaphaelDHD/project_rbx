import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:template_flutter_but/domain/entities/monument.entity.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';
import 'package:template_flutter_but/domain/repository/places.repository.dart';

@Singleton()
class PlacesService{
  final PlacesRepository _placesRepository;

  final ValueNotifier<PlaceEntity?> placeValueNotifier =
      ValueNotifier<PlaceEntity?>(null);

  PlacesService({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository;

  void getPlaces() async {
    final PlaceEntity places = await _placesRepository.getPlaces();
    placeValueNotifier.value = places;
  }

  void addPlacesWithOffset({required int offset}) async {
    final PlaceEntity places = await _placesRepository.getPlacesWithOffset(offset: offset);
    final List<MonumentEntity> updatedResults = List<MonumentEntity>.from(placeValueNotifier.value?.results ?? <MonumentEntity>[])
      ..addAll(places.results ?? <MonumentEntity>[]);
    placeValueNotifier.value = PlaceEntity(
      totalCount: places.totalCount,
      results: updatedResults,
    );
  }
}
