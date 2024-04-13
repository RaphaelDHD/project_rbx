import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:template_flutter_but/data/network/models/place.model.dart';
import 'package:template_flutter_but/domain/dao/place.dao.dart';

part 'place.dao_impl.g.dart';

@HiveType(typeId: 0)
@Singleton(as: PlaceDao)
class PlaceDaoImpl implements PlaceDao {
  final String _boxName = 'places';

  Future<Box<PlaceModel>> _openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<PlaceModel>(_boxName);
    }
    return Hive.box<PlaceModel>(_boxName);
  }

  @override
  Future<void> addPlace(PlaceModel place) async {
    final Box<PlaceModel> box = await _openBox();
    await box.add(place);
  }

  @override
  Future<PlaceModel> getPlaces() async {
    final Box<PlaceModel> box = await _openBox();
    return box.values.toList()[0];
  }

  @override
  Future<void> updatePlace(PlaceModel updatedPlace) async {
    final Box<PlaceModel> box = await _openBox();
    await box.add(updatedPlace);
  }
}
