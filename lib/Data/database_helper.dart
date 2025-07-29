import 'package:connex/Data/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;
  DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'contacts.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE contacts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            number TEXT,                  -- Added number field
            email TEXT,
            notes TEXT,
            isFavorite INTEGER
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE contacts ADD COLUMN number TEXT');
        }
      },
    );
  }

  Future<int> insertContact(Contact contact) async {
    final db = await database;
    return await db.insert('contacts', contact.toMap());
  }

  Future<List<Contact>> getContacts({bool favoritesOnly = false}) async {
    final db = await database;
    final result = await db.query(
      'contacts',
      where: favoritesOnly ? 'isFavorite = ?' : null,
      whereArgs: favoritesOnly ? [1] : null,
      orderBy: 'name ASC',
    );
    return result.map((e) => Contact.fromMap(e)).toList();
  }

  Future<void> deleteContact(int id) async {
    final db = await database;
    await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> toggleFavorite(Contact contact) async {
    final db = await database;
    await db.update(
      'contacts',
      {'isFavorite': contact.isFavorite ? 0 : 1},
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }
  Future<void> updateContact(Contact contact) async {
    final db = await database;
    await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }
  Future<Contact?> getContactById(int id) async {
    final db = await database;
    final result = await db.query('contacts', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? Contact.fromMap(result.first) : null;
  }



}
