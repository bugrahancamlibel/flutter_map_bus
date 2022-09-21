import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class User {
  final int id;
  final String name;
  final String password;

  User({required this.id, required this.name, required this.password});

  factory User.fromMap(Map<String, dynamic> json) =>
      User(id: json['id'], name: json['name'], password: json['password']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'password': password,
    };
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;


  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE app(
          id INTEGER PRIMARY KEY,
          name TEXT,
          password text
      )
      ''');
    User user = User(id: 1, name: "user", password: "password");
    var data_base = DatabaseHelper.instance;
    data_base.add(user);
  }

  Future<List<User>> getUser() async {
    Database db = await instance.database;
    var user = await db.query('app', orderBy: 'name');
    List<User> groceryList =
    user.isNotEmpty ? user.map((c) => User.fromMap(c)).toList() : [];
    return groceryList;
  }

  Future login(User user) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT * FROM user WHERE username = '${user.name}' and password = '${user.password}'");

  }

  Future<int> add(User user) async {
    Database db = await instance.database;
    return await db.insert('app', user.toMap());
  }

}


final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier(null);
});

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier(User? state) : super(state);

  setCurrentUser(User user) {
    state = user;
  }
  Future<User> getLogin(String username, String password) async {
    final DatabaseHelper instance = DatabaseHelper._privateConstructor();
    var dbClient = await instance.database;
    var res = await dbClient.rawQuery("SELECT * FROM app WHERE name = '$username' and password = '$password'");

    if (res.isNotEmpty) {
      state = User(id: 233, name: username, password: password); //TODO: fix the id.
      return User.fromMap(res.first);
    }
    // throw Exception("User not found.");
    return User(id: -1, name: "fail", password: "fail");
  }
}