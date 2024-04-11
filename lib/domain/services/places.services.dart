import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:template_flutter_but/domain/entities/favortie.entity.dart';
import 'package:template_flutter_but/domain/entities/monument.entity.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';
import 'package:template_flutter_but/domain/repository/places.repository.dart';

@Singleton()
class PlacesService {
  final PlacesRepository _placesRepository;

  final ValueNotifier<PlaceEntity?> placeValueNotifier =
      ValueNotifier<PlaceEntity?>(null);

  final ValueNotifier<FavoriteEntity> favoriteValueNotifier =
      ValueNotifier<FavoriteEntity>(FavoriteEntity(favoriteListId: <int>[]));

  PlacesService({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository;

  void getPlaces() async {
    final PlaceEntity places = await _placesRepository.getPlaces();
    placeValueNotifier.value = places;
  }

  void addPlacesWithOffset({required int offset}) async {
    final PlaceEntity places =
        await _placesRepository.getPlacesWithOffset(offset: offset);
    final List<MonumentEntity> updatedResults = List<MonumentEntity>.from(
        placeValueNotifier.value?.results ?? <MonumentEntity>[])
      ..addAll(places.results ?? <MonumentEntity>[]);
    placeValueNotifier.value = PlaceEntity(
      totalCount: places.totalCount,
      results: updatedResults,
    );
  }

  void addToFavorite({required int id}) {
    final List<int> updatedFavoriteListId =
        List<int>.from(favoriteValueNotifier.value.favoriteListId)..add(id);
    favoriteValueNotifier.value = FavoriteEntity(
      favoriteListId: updatedFavoriteListId,
    );
  }

  void removeFromFavorite({required int id}) {
    final List<int> updatedFavoriteListId =
        List<int>.from(favoriteValueNotifier.value.favoriteListId)..remove(id);
    favoriteValueNotifier.value = FavoriteEntity(
      favoriteListId: updatedFavoriteListId,
    );
  }

  bool isFavorite({required int id}) {
    return favoriteValueNotifier.value.favoriteListId.contains(id);
  }

}
