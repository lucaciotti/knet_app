import 'dart:async';

import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:knet_app/models/_abstract_model.dart';

class DbHelper {
  static final DbHelper _instance = new DbHelper.internal();
  factory DbHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  DbHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {

    await db.transaction((txn) async {
      await txn.execute("CREATE TABLE User (_id INTEGER PRIMARY KEY, nickname TEXT, email TEXT, lang TEXT, ditta TEXT)");
      
      await txn.execute("CREATE TABLE Token (_id INTEGER PRIMARY KEY, token_type TEXT, expires_in INTEGER, access_token TEXT, refresh_token TEXT)"); 
      print("Created tables");     
    });
  }

  // FUNZIONI HELPER PER INTERAGIRE CON IL DATABASE
  Future<Model> insert(String tableName, Model someModel) async {
    Database dbClient = await db;
    someModel.id = await dbClient.insert(tableName, someModel.toMap());
    return someModel;
  }

  Future<Map> getFirst(String tableName) async {
    Database dbClient = await db;
    List<Map> maps = await dbClient.query(tableName);
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }

  Future<Map> getFromId(String tableName, int id) async {
    Database dbClient = await db;
    List<Map> maps = await dbClient.query(tableName,
        where: "_id = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }

  Future<int> deleteFromId(String tableName, int id) async {
    Database dbClient = await db;
    return await dbClient.delete(tableName, where: "_id = ?", whereArgs: [id]);
  }

  Future<int> updateFromId(String tableName, Model someModel) async {
    Database dbClient = await db;
    return await dbClient.update(tableName, someModel.toMap(),
        where: "_id = ?", whereArgs: [someModel.id]);
  }

  Future<int> truncateTable(String tableName) async {
    var dbClient = await db;
    int res = await dbClient.delete(tableName);
    return res;
  }

  // Future close() async => db.close();

}
