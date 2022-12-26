import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSquelite {
  //docs para referencia https://pub.dev/packages/sqflite
  //PRECISA DE FATO RETORNAR E NÃO CRIAR UM CALBACK
  static Future<Database> instanceDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "great.db");
    return (await openDatabase(path, version: 1,
        onCreate: (Database db, int verions) async {
      await db.execute(
          'CREATE TABLE  Places (id INTEGER PRIMARY KEY, title TEXT,file TEXT,latitude REAL,longitude REAL, address TEXT)');
    }));
  }

  static Future<void> insertValue(
      {required String nameTable, required Map<String, dynamic> data}) async {
    final database = await instanceDatabase();
    database.insert(nameTable, data);
  }

  static Future<List<Map<String, dynamic>>> returnPlaces(
      String nameTable) async {
    final database = await instanceDatabase();
    return database.query(nameTable);
  }
}
