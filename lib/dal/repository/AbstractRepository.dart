import 'package:flutterapp/bo/BaseObject.dart';
import 'package:flutterapp/dal/DatabaseProvider.dart';
import 'package:flutterapp/dal/repository/InterfaceRepository.dart';
import '../dao/Dao.dart';

abstract class AbstractRepository<T extends BaseObject,D extends Dao<T>> implements InterfaceRepository<T> {

  D dao;
  
  @override
  DatabaseProvider databaseProvider;

  AbstractRepository(this.databaseProvider,this.dao);

  @override
  Future<T> insert(T t) async {
    final db = await databaseProvider.db();
    t.id = await db.insert(dao.tableName, dao.toMap(t));
    return t;
  }

  @override
  Future<T> delete(T t) async {
    final db = await databaseProvider.db();
    await db.delete(dao.tableName,
        where: dao.columnId + " = ?", whereArgs: [t.id]);
    return t;
  }

  @override
  Future<T> update(T t) async {
    final db = await databaseProvider.db();
    await db.update(dao.tableName, dao.toMap(t),
        where: dao.columnId + " = ?", whereArgs: [t.id]);
    return t;
  }

  @override
  Future<List<T>> getAll() async {
    final db = await databaseProvider.db();
    List<Map> maps = await db.query(dao.tableName);
    return dao.fromList(maps);
  }

}
