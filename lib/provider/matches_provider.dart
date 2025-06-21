import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permutabrasil/services/user_service.dart';
import 'package:permutabrasil/viewModel/match_view_model.dart';

class MatchesNotifier extends StateNotifier<List<MatchViewModel>> {
  MatchesNotifier() : super([]);

  DateTime? _ultimaRequisicao;

  DateTime? get ultimaRequisicao => _ultimaRequisicao;
  Future<void> carregarMatches() async {
    final response = await UserService.getMatches();

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      state = data
          .map((item) => MatchViewModel.fromJson(item as Map<String, dynamic>))
          .toList();
      _ultimaRequisicao = DateTime.now();
    } else {
      throw response;
    }
  }
}
