import 'package:permuta_brasil/models/autenticao_model.dart';
import 'package:permuta_brasil/utils/app_constantes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sessao {
  String token;
  String nome;
  String email;
  Usuario usuario;
  List<Permissao> permissoes;

  Sessao({
    required this.token,
    required this.nome,
    required this.email,
    required this.usuario,
    required this.permissoes,
  });

  factory Sessao.fromJson(Map<String, dynamic> json) {
    return Sessao(
      token: json['token'],
      nome: json['nome'],
      email: json['email'],
      usuario: Usuario.fromJson(json['usuario']),
      permissoes: (json['permissoes'] as List)
          .map((perm) => Permissao.fromJson(perm))
          .toList(),
    );
  }
  void setSession(SharedPreferences prefs, AutenticacaoModel model) {
    prefs.setString(PrefsKey.authToken, token);
    prefs.setBool("ativo", usuario.ativo);
    prefs.setString("nomeUsuario", usuario.nome);
    prefs.setInt(PrefsKey.userId, usuario.id);
    List<String> permissoesStrings =
        permissoes.map((perm) => perm.permissao).toList();
    prefs.setStringList("regrasAcesso", permissoesStrings);
    prefs.setString("email", model.login!);
  }
}

class Usuario {
  int id;
  String nome;
  String email;
  bool ativo;
  int credito;
  List<Permissao> permissoes;
  bool enabled;
  List<Permissao> authorities;
  String username;
  bool accountNonExpired;
  bool accountNonLocked;
  bool credentialsNonExpired;

  Usuario({
    required this.id,
    required this.nome,
    required this.email,
    required this.ativo,
    required this.credito,
    required this.permissoes,
    required this.enabled,
    required this.authorities,
    required this.username,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      ativo: json['ativo'],
      credito: json['credito'],
      permissoes: (json['permissoes'] as List)
          .map((perm) => Permissao.fromJson(perm))
          .toList(),
      enabled: json['enabled'],
      authorities: (json['authorities'] as List)
          .map((auth) => Permissao.fromJson(auth))
          .toList(),
      username: json['username'],
      accountNonExpired: json['accountNonExpired'],
      accountNonLocked: json['accountNonLocked'],
      credentialsNonExpired: json['credentialsNonExpired'],
    );
  }
}

class Permissao {
  String permissao;

  Permissao({required this.permissao});

  factory Permissao.fromJson(Map<String, dynamic> json) {
    return Permissao(
      permissao: json['permissao'],
    );
  }
}
