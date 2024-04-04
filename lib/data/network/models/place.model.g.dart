// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceModel _$PlaceModelFromJson(Map<String, dynamic> json) => PlaceModel(
      totalCount: json['total_count'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MonumentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaceModelToJson(PlaceModel instance) =>
    <String, dynamic>{
      'total_count': instance.totalCount,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };
