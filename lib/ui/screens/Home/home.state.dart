import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:template_flutter_but/domain/entities/place.entity.dart';
import 'package:template_flutter_but/ui/abstraction/view_state_abs.dart';

part 'home.state.g.dart';

@CopyWith()
class HomeState extends ViewStateAbs {
  final bool loading;
  final PlaceEntity? places;

  const HomeState({required this.loading, required this.places});

  const HomeState.initial()
      : loading = false,
        places = null;

  @override
  List<Object?> get props => <Object?>[
        loading,
        places,
      ];
}
