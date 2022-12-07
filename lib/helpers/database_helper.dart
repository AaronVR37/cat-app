import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import '../models/cat_model.dart';

class DatabaseHelper{
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database; 
  Future<Database> get database async=> _database??= await _initDatabase();

  Future<Database>_initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'animals.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }
  Future _onCreate(Database db, int version) async{
    db.execute(
      '''
      CREATE TABLE cats(
        id INTEGER PRIMARY KEY,
        Race TEXT,
        Name TEXT,
        Image TEXT,
        Food TEXT
      )
      '''
    );
  }

  Future<int>add(Cat cat) async {
    Database db = await instance.database;
    return await db.insert('cats', cat.toMap());
  }

  Future<int>delete(int id)async{
    Database db = await instance.database;
    return await db.delete('cats',where: 'id=?', whereArgs: [id]);
  }

  Future<int>update(Cat cat) async {
    Database db = await instance.database;
    return await db.update('cats', cat.toMap(), where: 'id = ?', whereArgs: [cat.id]);
  }

  Future<List<Cat>>getCats() async {
    Database db = await instance.database;
    var cats = await db.query('cats', orderBy: 'race');
    
    List<Cat>catsList = 
      cats.isNotEmpty? cats.map((e) => Cat.formMap(e)).toList():[];
    return catsList;

  }
}

  
  