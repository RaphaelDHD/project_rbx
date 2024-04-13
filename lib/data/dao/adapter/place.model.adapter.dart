import 'package:hive/hive.dart';
import 'package:template_flutter_but/data/network/models/place.model.dart';
import 'package:template_flutter_but/data/network/models/monument.model.dart';

class PlaceModelAdapter extends TypeAdapter<PlaceModel> {
  @override
  final int typeId = 0; // Unique identifier for the adapter

  @override
  PlaceModel read(BinaryReader reader) {
    // Deserialize the PlaceModel from the binary data
    final int totalCount = reader.readInt();
    final int resultsLength = reader.readInt();
    final List<MonumentModel> results = <MonumentModel>[];
    for (int i = 0; i < resultsLength; i++) {
      results.add(reader.read());
    }
    return PlaceModel(totalCount: totalCount, results: results);
  }

  @override
  void write(BinaryWriter writer, PlaceModel obj) {
    // Serialize the PlaceModel into binary data
    writer.writeInt(obj.totalCount!);
    writer.writeInt(obj.results!.length);
    for (final MonumentModel monumentModel in obj.results!) {
      writer.write(monumentModel);
    }
  }
}
