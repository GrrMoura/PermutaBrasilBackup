class UsuarioModel {
  int? id;
  String? nome;
  String? patenteClasse;
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
  List<int>? estadosDestino;
  bool? isEnabled;
  String? username;
  // List<AuthorityModel>? authorities;
  bool? isAccountNonExpired;
  bool? isAccountNonLocked;
  bool? isCredentialsNonExpired;

  String? imagemFuncionalBase64;

  UsuarioModel(
      {this.cpf,
      this.id,
      this.imagemFuncionalBase64,
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
      this.patenteClasse,
      // this.permissoes,
      this.isEnabled,
      this.username,
      //  this.authorities,
      this.isAccountNonExpired,
      this.isAccountNonLocked,
      this.isCredentialsNonExpired,
      this.telefone,
      this.estadosDestino});

  Map<String, dynamic> toJson() => {
        'cpf': cpf,
        'imagemFuncionalBase64': imagemFuncionalBase64,
        'dataNascimento': dataNascimento!.toIso8601String(),
        'instituicaoId': instituicaoId,
        'estadoOrigemId': estadoOrigemId,
        'email': email,
        'dataInclusao': dataInclusao!.toIso8601String(),
        'nome': nome,
        'patenteClasse': patenteClasse,
        'senha': senha,
        'telefone': telefone,
        'id': id,
        'ativo': ativo,
        'credito': credito,
        'estadosDestino': estadosDestino,
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
      patenteClasse: json['patenteClasse'],
      estadosDestino: json['estadosDestino'] != null
          ? List<int>.from(json['estadosDestino'])
          : [],
      imagemFuncionalBase64: json['imagemFuncionalBase64'],
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
