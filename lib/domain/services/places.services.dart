import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:template_flutter_but/data/network/models/place.model.dart';
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

  final ValueNotifier<int> selectedIdValueNotifier = ValueNotifier<int>(-1);

  PlacesService({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository;

  void setId({required int id}) {
    selectedIdValueNotifier.value = id;
  }

  void getPlaces() async {
    final PlaceEntity places = await _placesRepository.getPlaces();
    placeValueNotifier.value = places;
  }

  void getFavorite() async {
    final FavoriteEntity favorite = await _placesRepository.getFavorite();
    favoriteValueNotifier.value = favorite;
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
    PlaceModel model = PlaceModel.fromEntity(placeValueNotifier.value!);
    _placesRepository.savePlaces(model);
  }

  void addToFavorite({required int id}) {
    final List<int> updatedFavoriteListId =
        List<int>.from(favoriteValueNotifier.value.favoriteListId)..add(id);
    favoriteValueNotifier.value = FavoriteEntity(
      favoriteListId: updatedFavoriteListId,
    );
    _placesRepository.addToFavorite(id: id);
  }

  void removeFromFavorite({required int id}) {
    final List<int> updatedFavoriteListId =
        List<int>.from(favoriteValueNotifier.value.favoriteListId)..remove(id);
    favoriteValueNotifier.value = FavoriteEntity(
      favoriteListId: updatedFavoriteListId,
    );
    _placesRepository.removeFromFavorite(id: id);
  }

  bool isFavorite({required int id}) {
    return favoriteValueNotifier.value.favoriteListId.contains(id);
  }

  void addSelectedToFavorite() {
    final List<int> updatedFavoriteListId =
        List<int>.from(favoriteValueNotifier.value.favoriteListId)
          ..add(selectedIdValueNotifier.value);
    favoriteValueNotifier.value = FavoriteEntity(
      favoriteListId: updatedFavoriteListId,
    );
  }

  void removeSelectedFromFavorite() {
    final List<int> updatedFavoriteListId =
        List<int>.from(favoriteValueNotifier.value.favoriteListId)
          ..remove(selectedIdValueNotifier.value);
    favoriteValueNotifier.value = FavoriteEntity(
      favoriteListId: updatedFavoriteListId,
    );
  }

  bool isSelectedFavorite() {
    return favoriteValueNotifier.value.favoriteListId
        .contains(selectedIdValueNotifier.value);
  }

  MonumentEntity? getCurrentMonument() {
    final PlaceEntity? places = placeValueNotifier.value;
    return places?.results?.firstWhere(
      (MonumentEntity element) => element.id == selectedIdValueNotifier.value,
    );
  }
}
