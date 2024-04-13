import 'package:hive/hive.dart';
import 'package:template_flutter_but/data/network/models/photo.model.dart';

class PhotoModelAdapter extends TypeAdapter<PhotoModel> {
  @override
  final int typeId = 2; // Unique identifier for the adapter

  @override
  PhotoModel read(BinaryReader reader) {
    return PhotoModel(
      exifOrientation: reader.readInt(),
      thumbnail: reader.readBool(),
      filename: reader.readString(),
      format: reader.readString(),
      width: reader.readInt(),
      id: reader.readString(),
      height: reader.readInt(),
      url: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, PhotoModel obj) {
    writer.writeInt(obj.exifOrientation ?? 0);
    writer.writeBool(obj.thumbnail ?? false);
    writer.writeString(obj.filename ?? '');
    writer.writeString(obj.format ?? '');
    writer.writeInt(obj.width ?? 0);
    writer.writeString(obj.id ?? '');
    writer.writeInt(obj.height ?? 0);
    writer.writeString(obj.url ?? '');
  }
}
