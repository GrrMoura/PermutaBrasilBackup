import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permuta_brasil/services/user_service.dart';
import 'package:permuta_brasil/viewModel/match_view_model.dart';

class MatchesNotifier extends StateNotifier<List<MatchViewModel>> {
  MatchesNotifier() : super([]);

  Future<void> carregarMatches() async {
    final response = await UserService.getMatches();

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      state = data
          .map((item) => MatchViewModel.fromJson(item['profissional']))
          .toList();
    } else {
      throw Exception(
          'Erro ao buscar matches'); // Agora erro é lançado para ser tratado no Widget
    }
  }
}
