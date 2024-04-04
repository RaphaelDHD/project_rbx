import 'package:template_flutter_but/domain/entities/monument.entity.dart';

class PlaceEntity {
  final int? totalCount;
  final List<MonumentEntity>? results;
  const PlaceEntity({required this.totalCount, required this.results});
}
