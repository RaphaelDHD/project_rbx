import 'package:template_flutter_but/data/local/models/favorite.model.dart';

abstract class FavoriteDao {
  Future<void> addToFavorite({required int favoriteId});
  Future<void> removeFromFavorite({required int favoriteId});
  Future<FavoriteModel> getFavorite();
}
