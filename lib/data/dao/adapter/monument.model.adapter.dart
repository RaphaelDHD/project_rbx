import 'package:hive/hive.dart';
import 'package:template_flutter_but/data/network/models/monument.model.dart';
import 'package:template_flutter_but/data/network/models/photo.model.dart';

class MonumentModelAdapter extends TypeAdapter<MonumentModel> {
  @override
  final int typeId = 1; // Unique identifier for the adapter

  @override
  MonumentModel read(BinaryReader reader) {
    // Deserialize the MonumentModel from the binary data
    return MonumentModel(
      monumHisComId: reader.readInt(),
      appellationCourante: reader.readString(),
      photo: reader.read() as PhotoModel?,
      copyrightEtPropriete: reader.readString(),
      epoque: reader.readString(),
      siecle: List<String>.from(reader.readList()),
      precisionSurLaProtection: reader.readString(),
      dateDeProtection: reader.readString(),
      classement: reader.readString(),
      statut: reader.readString(),
      description: reader.readString(),
      historique: reader.readString(),
      auteur: reader.readString(),
      region: reader.readString(),
      departement: reader.readString(),
      commune: reader.readString(),
      niveauDeProtection: reader.readString(),
      codeDepartement: reader.readInt(),
      insee: reader.readInt(),
      adresseBanSig: reader.readString(),
      lat: reader.readString(),
      long: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, MonumentModel obj) {
    // Serialize the MonumentModel into binary data
    writer.writeInt(obj.monumHisComId);
    writer.writeString(obj.appellationCourante ?? '');
    writer.write(obj.photo);
    writer.writeString(obj.copyrightEtPropriete ?? '');
    writer.writeString(obj.epoque ?? '');
    writer.writeList(obj.siecle);
    writer.writeString(obj.precisionSurLaProtection ?? '');
    writer.writeString(obj.dateDeProtection ?? '');
    writer.writeString(obj.classement ?? '');
    writer.writeString(obj.statut ?? '');
    writer.writeString(obj.description ?? '');
    writer.writeString(obj.historique ?? '');
    writer.writeString(obj.auteur ?? '');
    writer.writeString(obj.region ?? '');
    writer.writeString(obj.departement ?? '');
    writer.writeString(obj.commune ?? '');
    writer.writeString(obj.niveauDeProtection ?? '');
    writer.writeInt(obj.codeDepartement ?? 0);
    writer.writeInt(obj.insee ?? 0);
    writer.writeString(obj.adresseBanSig ?? '');
    writer.writeString(obj.lat ?? '');
    writer.writeString(obj.long ?? '');
  }
}
