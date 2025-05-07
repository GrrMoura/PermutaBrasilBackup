import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();
  static const _cpfKey = "cpf";
  static const _senha = "senha";
  static const _tokenFmc = "tokenfcm";

  static Future<void> setCpf(String cpf) async {
    await _storage.write(key: _cpfKey, value: cpf);
  }

  static Future<String?> getCpf() async {
    return await _storage.read(key: _cpfKey);
  }

  static Future<void> deleteCpf() async {
    await _storage.delete(key: _cpfKey);
  }

  static Future<void> setSenha(String senha) async {
    await _storage.write(key: _senha, value: senha);
  }

  static Future<String?> getSenha() async {
    return await _storage.read(key: _senha);
  }

  static Future<void> setToken(String token) async {
    await _storage.write(key: _tokenFmc, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenFmc);
  }

  static Future<void> deleteSenha() async {
    await _storage.delete(key: _senha);
  }
}
