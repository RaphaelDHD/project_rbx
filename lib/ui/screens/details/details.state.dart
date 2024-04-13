import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:template_flutter_but/ui/abstraction/view_state_abs.dart';

part 'details.state.g.dart';

@CopyWith()
class DetailsState extends ViewStateAbs {
  bool isFavorite;

  DetailsState({required this.isFavorite});

  DetailsState.initial() : isFavorite = false;

  @override
  List<Object?> get props => <Object?>[
        isFavorite,
      ];
}
