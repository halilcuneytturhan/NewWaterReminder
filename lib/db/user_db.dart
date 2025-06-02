import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';

class UserDB {
  static final UserDB instance = UserDB._init();
  static Database? _database;

  UserDB._init();

  Future<Database> get db async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        dailyGoal REAL NOT NULL,
        consumedWater REAL NOT NULL
      )
    ''');
  }

  Future<void> insertUser(UserModel user) async {
    final database = await instance.db;
    await database.insert('users', user.toMap());
  }

  Future<List<UserModel>> getUsers() async {
    final database = await instance.db;
    final result = await database.query('users');
    return result.map((json) => UserModel.fromMap(json)).toList();
  }

  Future<void> deleteAllUsers() async {
    final database = await instance.db;
    await database.delete('users');
  }

  Future<void> updateUser(UserModel user) async {
    final database = await instance.db;
    await database.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> updateConsumedWater(int userId, double newValue) async {
    final database = await instance.db;
    await database.update(
      'users',
      {'consumedWater': newValue},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> deleteUserById(int id) async {
    final database = await instance.db;
    await database.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
