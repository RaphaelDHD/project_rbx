import 'package:json_annotation/json_annotation.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';

part 'place.model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class PlaceModel {
  final int? totalCount;

  const PlaceModel({required this.totalCount});

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);

  PlaceEntity get toEntity => PlaceEntity(totalCount: totalCount);
}
