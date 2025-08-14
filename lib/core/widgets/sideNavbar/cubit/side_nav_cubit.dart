import 'package:flutter_bloc/flutter_bloc.dart';

/// SideNavCubit
/// ---------------------------------------------------------------------------
/// Single source of truth for the side nav’s collapsed/expanded state.
/// - `false` => expanded (default)
/// - `true`  => collapsed (icons only)
class SideNavCubit extends Cubit<bool> {
  SideNavCubit() : super(false); // start expanded

  bool get isCollapsed => state;

  void toggle() => emit(!state);
  void collapse() => emit(true);
  void expand() => emit(false);
}
