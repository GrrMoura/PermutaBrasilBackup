import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permutabrasil/viewModel/profissional_view_model.dart';

final profissionalProvider =
    StateProvider<ProfissionalViewModel?>((ref) => null);

final visivelMatchProvider = Provider<bool>((ref) {
  final profissional = ref.watch(profissionalProvider);
  return profissional?.visivelMatch ?? false;
});
