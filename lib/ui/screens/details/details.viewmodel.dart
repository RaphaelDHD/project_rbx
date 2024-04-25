import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter_but/application/injections/initializer.dart';
import 'package:template_flutter_but/domain/entities/monument.entity.dart';
import 'package:template_flutter_but/domain/services/places.services.dart';
import 'package:template_flutter_but/ui/screens/details/details.state.dart';

final StateNotifierProvider<DetailsViewModel, DetailsState> detailsProvider =
    StateNotifierProvider<DetailsViewModel, DetailsState>(
  (StateNotifierProviderRef<DetailsViewModel, DetailsState> ref) =>
      DetailsViewModel(
    placesService: injector<PlacesService>(),
  ),
);

class DetailsViewModel extends StateNotifier<DetailsState> {
  final PlacesService _placesService;

  DetailsViewModel({required PlacesService placesService})
      : _placesService = placesService,
        super(DetailsState.initial()) {
    _init();
  }

  void _init() {
    _placesService.favoriteValueNotifier.addListener(() {
      setIsFavorite();
    });
    _placesService.selectedIdValueNotifier.addListener(() {
      setIsFavorite();
    });
    setIsFavorite();
  }

  void addToFavorite() {
    _placesService.addSelectedToFavorite();
  }

  void removeFromFavorite() {
    _placesService.removeSelectedFromFavorite();
  }

  MonumentEntity? getMonument() {
    return _placesService.getCurrentMonument();
  }

  void setIsFavorite() {
    final bool value = _placesService.isSelectedFavorite();
    state = state.copyWith(isFavorite: value);
  }
}
