// nome_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permutabrasil/provider/matches_provider.dart';
import 'package:permutabrasil/viewModel/match_view_model.dart';
import 'package:permutabrasil/viewModel/profissional_view_model.dart';

final nomeProvider = StateProvider<String?>((ref) => null);
final creditoProvider = StateProvider<int>((ref) => 0);
final statusProvider = StateProvider<bool>((ref) => false);

final profissionalProvider =
    StateProvider<ProfissionalViewModel?>((ref) => null);

final matchesProvider =
    StateNotifierProvider<MatchesNotifier, List<MatchViewModel>>((ref) {
  return MatchesNotifier();
});
