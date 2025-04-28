import 'package:permuta_brasil/models/authority_model.dart';
import 'package:permuta_brasil/models/permissao_model.dart';

class UsuarioModel {
  int? id;
  String? nome;
  String? email;
  String? cpf;
  String? telefone;
  String? senha;
  String? confirmarSenha;
  DateTime? dataNascimento;
  int? estadoOrigemId;
  DateTime? dataInclusao;
  int? instituicaoId;
  bool? ativo;
  double? credito;
  // List<PermissaoModel>? permissoes;
  List<int>? locais;
  bool? isEnabled;
  String? username;
  // List<AuthorityModel>? authorities;
  bool? isAccountNonExpired;
  bool? isAccountNonLocked;
  bool? isCredentialsNonExpired;

  //File? identidadeFuncional;

  UsuarioModel(
      {this.cpf,
      this.id,
      //  this.identidadeFuncional,
      this.dataNascimento,
      this.instituicaoId,
      this.estadoOrigemId,
      this.email,
      this.dataInclusao,
      this.confirmarSenha,
      this.senha,
      this.nome,
      this.ativo,
      this.credito,
      // this.permissoes,
      this.isEnabled,
      this.username,
      //  this.authorities,
      this.isAccountNonExpired,
      this.isAccountNonLocked,
      this.isCredentialsNonExpired,
      this.telefone,
      this.locais});

  Map<String, dynamic> toJson() => {
        'cpf': cpf,
        //  'identidadeFuncional': identidadeFuncional,
        'dataNascimento': dataNascimento!.toIso8601String(),
        'instituicaoId': instituicaoId,
        'estadoOrigemId': estadoOrigemId,
        'email': email,
        'dataInclusao': dataInclusao!.toIso8601String(),
        'nome': nome,
        'senha': senha,
        'telefone': telefone,
        'id': id,
        'ativo': ativo,
        'credito': credito,
        'locais': locais,
        //   'permissoes': PermissaoModel.toJsonList(permissoes ?? []),
        'isEnabled': isEnabled,
        'username': username,
        //   'authorities': AuthorityModel.toJsonList(authorities ?? []),
        'isAccountNonExpired': isAccountNonExpired,
        'isAccountNonLocked': isAccountNonLocked,
        'isCredentialsNonExpired': isCredentialsNonExpired
      };

  static UsuarioModel fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      ativo: json['ativo'],
      cpf: json['cpf'],
      id: json['id'],
      telefone: json['telefone'],
      nome: json['nome'],
      locais: json['locais'] != null ? List<int>.from(json['locais']) : [],
      // identidadeFuncional: json['identidadeFuncional'],
      //  dataNascimento: DateTime.parse(json['dataNascimento']),
      //  instituicoesId: List<int>.from(json['instituicoesId'] ?? []),
      estadoOrigemId: json['estadoOrigemId'],
      instituicaoId: json['instituicaoId'],
      email: json['email'],
      //  dataInclusao: DateTime.parse(json['dataInclusao']),
      credito: (json['credito'] != null)
          ? (json['credito'] as num).toDouble()
          : null,
      // permissoes: json['permissoes'] != null
      //     ? PermissaoModel.fromJsonList(json['permissoes'] as List)
      //     : [],
      isEnabled: json['isEnabled'],
      username: json['username'],
      // authorities: json['authorities'] != null
      //     ? AuthorityModel.fromJsonList(json['authorities'] as List)
      //     : [],
      isAccountNonExpired: json['isAccountNonExpired'],
      isAccountNonLocked: json['isAccountNonLocked'],
      isCredentialsNonExpired: json['isCredentialsNonExpired'],
    );
  }
}
