import 'package:template_flutter_but/domain/entities/favortie.entity.dart';

class FavoriteModel {
  final List<int>? favoriteListId;

  const FavoriteModel({required this.favoriteListId});

  FavoriteEntity get toEntity =>
      FavoriteEntity(favoriteListId: favoriteListId ?? <int>[]);
}
