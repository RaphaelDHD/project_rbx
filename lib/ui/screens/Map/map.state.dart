import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:template_flutter_but/domain/entities/marker.entity.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';
import 'package:template_flutter_but/ui/abstraction/view_state_abs.dart';

part 'map.state.g.dart';

@CopyWith()
class MapState extends ViewStateAbs {
  final PlaceEntity? places;
  List<MarkerEntity> markers = <MarkerEntity>[];
  MarkerEntity? selectedMarker = MarkerEntity(lat: 0.0, long: 0.0, title: '', imageUrl: '');

  MapState({required this.places, this.markers = const <MarkerEntity>[], this.selectedMarker});

  MapState.initial() : places = null, markers = const <MarkerEntity>[], selectedMarker = null;

  @override
  List<Object?> get props => <Object?>[
        places,
        markers,
        selectedMarker,
      ];
}
