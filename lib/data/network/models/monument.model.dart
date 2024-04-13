import 'package:json_annotation/json_annotation.dart';
import 'package:template_flutter_but/data/network/models/photo.model.dart';
import 'package:template_flutter_but/domain/entities/monument.entity.dart';

part 'monument.model.g.dart';

  @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
  class MonumentModel {
    final int monumHisComId;
    final String? appellationCourante;
    final PhotoModel? photo;
    final String? copyrightEtPropriete;
    final String? epoque;
    final List<String> siecle;
    final String? precisionSurLaProtection;
    final String? dateDeProtection;
    final String? classement;
    final String? statut;
    final String? description;
    final String? historique;
    final String? auteur;
    final String? region;
    final String? departement;
    final String? commune;
    final String? niveauDeProtection;
    final int? codeDepartement;
    final int? insee;
    final String? adresseBanSig;
    final String? lat;
    final String? long;

    const MonumentModel({
      required this.monumHisComId,
      required this.appellationCourante,
      required this.photo,
      required this.copyrightEtPropriete,
      required this.epoque,
      required this.siecle,
      required this.precisionSurLaProtection,
      required this.dateDeProtection,
      required this.classement,
      required this.statut,
      required this.description,
      required this.historique,
      required this.auteur,
      required this.region,
      required this.departement,
      required this.commune,
      required this.niveauDeProtection,
      required this.codeDepartement,
      required this.insee,
      required this.adresseBanSig,
      required this.lat,
      required this.long,
    });

    factory MonumentModel.fromJson(Map<String, dynamic> json) =>
        _$MonumentModelFromJson(json);

    Map<String, dynamic> toJson() => _$MonumentModelToJson(this);

    MonumentEntity get toEntity => MonumentEntity(
          id: monumHisComId,
          name: appellationCourante,
          photo: photo?.toEntity,
          copyrightEtPropriete: copyrightEtPropriete,
          epoque: epoque,
          siecle: siecle,
          precisionSurLaProtection: precisionSurLaProtection,
          dateDeProtection: dateDeProtection,
          classement: classement,
          statut: statut,
          description: description,
          historique: historique,
          auteur: auteur,
          region: region,
          departement: departement,
          commune: commune,
          niveauDeProtection: niveauDeProtection,
          codeDepartement: codeDepartement,
          insee: insee,
          adresseBanSig: adresseBanSig,
          lat: lat == null ? null : double.parse(lat!),
          long: long == null ? null : double.parse(long!),
        );

    factory MonumentModel.fromEntity(MonumentEntity entity) => MonumentModel(
          monumHisComId: entity.id,
          appellationCourante: entity.name,
          photo:
              entity.photo == null ? null : PhotoModel.fromEntity(entity.photo!),
          copyrightEtPropriete: entity.copyrightEtPropriete,
          epoque: entity.epoque,
          siecle: entity.siecle,
          precisionSurLaProtection: entity.precisionSurLaProtection,
          dateDeProtection: entity.dateDeProtection,
          classement: entity.classement,
          statut: entity.statut,
          description: entity.description,
          historique: entity.historique,
          auteur: entity.auteur,
          region: entity.region,
          departement: entity.departement,
          commune: entity.commune,
          niveauDeProtection: entity.niveauDeProtection,
          codeDepartement: entity.codeDepartement,
          insee: entity.insee,
          adresseBanSig: entity.adresseBanSig,
          lat: entity.lat?.toString(),
          long: entity.long?.toString(),
        );
  }
