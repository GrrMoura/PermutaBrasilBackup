// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//     _database = await initializeDatabase();
//     return _database!;
//   }

//   Future<Database> initializeDatabase() async {
//     String path = join(await getDatabasesPath(), 'permutaBrasil.db');
//     return await openDatabase(
//       path,
//       version: 1, // Versão inicial do banco de dados
//       onCreate: _createDatabase,
//     );
//   }

//   void _createDatabase(Database db, int version) async {
//     // Tabela Estados
//     await db.execute('''
//       CREATE TABLE Estados (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         nome TEXT NOT NULL
//       )
//     ''');

//     List<String> estados = [
//       'Acre',
//       'Alagoas',
//       'Amapá',
//       'Amazonas',
//       'Bahia',
//       'Ceará',
//       'Distrito Federal',
//       'Espírito Santo',
//       'Goiás',
//       'Maranhão',
//       'Mato Grosso',
//       'Mato Grosso do Sul',
//       'Minas Gerais',
//       'Pará',
//       'Paraíba',
//       'Paraná',
//       'Pernambuco',
//       'Piauí',
//       'Rio de Janeiro',
//       'Rio Grande do Norte',
//       'Rio Grande do Sul',
//       'Rondônia',
//       'Roraima',
//       'Santa Catarina',
//       'São Paulo',
//       'Sergipe',
//       'Tocantins'
//     ];

//     Batch batch = db.batch();
//     for (int i = 0; i < estados.length; i++) {
//       batch.insert('Estados', {'id': i + 1, 'nome': estados[i]});
//     }

//     await batch.commit();
//   }

//   Future<List<Map<String, dynamic>>> getEstados() async {
//     Database db = await database;
//     List<Map<String, dynamic>> estados =
//         await db.query('Estados', orderBy: 'nome');
//     return estados;
//   }
// }
