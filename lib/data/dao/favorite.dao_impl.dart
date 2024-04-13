import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:template_flutter_but/data/local/models/favorite.model.dart';
import 'package:template_flutter_but/domain/dao/favorite.dao.dart';

part 'favorite.dao_impl.g.dart';

@HiveType(typeId: 1)
@Singleton(as: FavoriteDao)
class FavoriteDaoImpl implements FavoriteDao {
  final String _boxName = 'favorite';

  Future<Box<int>> _openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<int>(_boxName);
    }
    return Hive.box<int>(_boxName);
  }

  @override
  Future<void> addToFavorite({required int favoriteId}) async {
    final Box<int> box = await _openBox();
    await box.add(favoriteId);
  }

  @override
  Future<void> removeFromFavorite({required int favoriteId}) async {
    final Box<int> box = await _openBox();
    final int index = box.values.toList().indexOf(favoriteId);
    if (index != -1) {
      await box.deleteAt(index);
    }
  }

  @override
  Future<FavoriteModel> getFavorite() async {
    final Box<int> box = await _openBox();
    return FavoriteModel(favoriteListId: box.values.toList());
  }
}
