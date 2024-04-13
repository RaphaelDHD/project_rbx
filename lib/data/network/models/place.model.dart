import 'package:json_annotation/json_annotation.dart';
import 'package:template_flutter_but/data/network/models/monument.model.dart';
import 'package:template_flutter_but/domain/entities/monument.entity.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';

part 'place.model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PlaceModel {
  final int? totalCount;
  final List<MonumentModel>? results;

  const PlaceModel({required this.totalCount, required this.results});

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);

  PlaceEntity get toEntity => PlaceEntity(
      totalCount: totalCount,
      results: results?.map((MonumentModel e) => e.toEntity).toList());

  factory PlaceModel.fromEntity(PlaceEntity entity) => PlaceModel(
        totalCount: entity.totalCount,
        results: entity.results
            ?.map((MonumentEntity e) => MonumentModel.fromEntity(e))
            .toList(),
      );
}
