// TODO Implement this library.
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<void> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'storepro.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        phone TEXT,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price REAL,
        cost REAL,
        stock INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE sales(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        total REAL,
        profit REAL
      )
    ''');
  }

  Future<int> registerUser(String phone, String password) async {
    final db = _database!;
    return await db.insert('users', {
      'phone': phone,
      'password': password,
    });
  }

  Future<bool> login(String phone, String password) async {
    final db = _database!;
    final res = await db.query(
      'users',
      where: 'phone=? AND password=?',
      whereArgs: [phone, password],
    );
    return res.isNotEmpty;
  }
}
Future<int> addProduct(String name, double price, double cost, int stock) async {
  var _database;
  final db = _database!;
  return await db.insert('products', {
    'name': name,
    'price': price,
    'cost': cost,
    'stock': stock,
  });
}

Future<List<Map<String, dynamic>>> getAllProducts() async {
  var _database;
  final db = _database!;
  return await db.query('products');
}