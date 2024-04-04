import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:template_flutter_but/ui/abstraction/view_state_abs.dart';

part 'home.state.g.dart';

@CopyWith()
class HomeState extends ViewStateAbs {
  final bool loading;

  const HomeState({required this.loading});

  const HomeState.initial() : loading = false;

  @override
  List<Object?> get props => <Object?>[
        loading,
      ];
}
