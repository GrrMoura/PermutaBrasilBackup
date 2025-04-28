import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permuta_brasil/provider/matches_provider.dart';
import 'package:permuta_brasil/viewModel/match_view_model.dart';

final matchesProvider =
    StateNotifierProvider<MatchesNotifier, List<MatchViewModel>>((ref) {
  return MatchesNotifier();
});
