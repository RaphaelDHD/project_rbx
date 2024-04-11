import 'package:template_flutter_but/domain/entities/photo.entity.dart';

class MonumentEntity {
  final int id;
  final String? name;
  final PhotoEntity? photo;
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
  final double? lat;
  final double? long;

  const MonumentEntity({
    required this.id,
    required this.name,
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

  set isFavorite(bool isFavorite) {}


}