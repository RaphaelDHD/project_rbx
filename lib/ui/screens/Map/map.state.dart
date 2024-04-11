import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';
import 'package:template_flutter_but/ui/abstraction/view_state_abs.dart';

part 'map.state.g.dart';

@CopyWith()
class MapState extends ViewStateAbs {
  final PlaceEntity? places;

  const MapState({required this.places});

  const MapState.initial() : places = null;

  @override
  List<Object?> get props => <Object?>[
        places,
      ];
}
