import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter_but/application/injections/initializer.dart';
import 'package:template_flutter_but/domain/services/places.services.dart';
import 'package:template_flutter_but/ui/abstraction/view_model_abs.dart';
import 'package:template_flutter_but/ui/screens/Details/details.screen.dart';
import 'package:template_flutter_but/ui/screens/home/home.state.dart';

final StateNotifierProvider<HomeViewModel, HomeState> homeProvider =
    StateNotifierProvider<HomeViewModel, HomeState>(
  (StateNotifierProviderRef<HomeViewModel, HomeState> ref) => HomeViewModel(
    placesService: injector<PlacesService>(),
  ),
);

class HomeViewModel extends ViewModelAbs<HomeViewModel, HomeState> {
  final PlacesService _placesService;

  HomeViewModel({required PlacesService placesService})
      : _placesService = placesService,
        super(const HomeState.initial()) {
    _init();
  }

  void updateLoading(bool value) {
    state = state.copyWith(loading: value);
  }

  void _init() async {
    _placesService.placeValueNotifier.addListener(() {
      state = state.copyWith(places: _placesService.placeValueNotifier.value);
    });
    _placesService.favoriteValueNotifier.addListener(() {
      state =
          state.copyWith(favorite: _placesService.favoriteValueNotifier.value);
    });
    updateLoading(true);
    _placesService.getPlaces();
    _placesService.getFavorite();
    updateLoading(false);
  }

  Future<void> getPlaces() async {
    _placesService.getPlaces();
  }

  void getPlacesWithOffset() async {
    _placesService.addPlacesWithOffset(
        offset: state.places?.results?.length ?? 0);
  }

  void addToFavorite({required int id}) {
    _placesService.addToFavorite(id: id);
  }

  void removeFromFavorite({required int id}) {
    _placesService.removeFromFavorite(id: id);
  }

  bool isFavorite({required int id}) {
    return _placesService.isFavorite(id: id);
  }

  void goToDetails({required int id, required BuildContext context}) {
    _placesService.setId(id: id);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const DetailsScreen(),
        ));
  }
}
