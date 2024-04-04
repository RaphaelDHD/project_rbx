import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_flutter_but/ui/abstraction/view_state_abs.dart';

/// Base class for viewmodel
abstract class ViewModelAbs<T, S extends ViewStateAbs>
    extends StateNotifier<S> {
  ///
  ViewModelAbs(super.state);
}
