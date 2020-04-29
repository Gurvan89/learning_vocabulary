import 'package:flutterapp/dal/dao/VocabularyDao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static const DATABASE_NAME = "voc_app";
  static final _instance = DatabaseProvider._internal();
  static DatabaseProvider get = _instance;
  bool isInitialized = false;
  Database _db;

  DatabaseProvider._internal();

  Future<Database> db() async {
    if (!isInitialized) await _init();
    return _db;
  }

  Future _init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DATABASE_NAME);

    _db = await openDatabase(path,
        version: 2, onCreate: _create, onUpgrade: _upgrade);


  }

  _create(Database db, int version) async {
    await db.execute(VocabularyDao().createTableQuery);
    await db.execute(VocabularyDao().updateV2);
    await db.execute(VocabularyDao().insert);
  }

  void _upgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute(VocabularyDao().updateV2);
    }
  }
}
