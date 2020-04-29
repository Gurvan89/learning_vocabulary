import 'package:flutterapp/bo/BaseObject.dart';
import 'package:flutterapp/dal/DatabaseProvider.dart';

abstract class InterfaceRepository<T extends BaseObject> {

  DatabaseProvider databaseProvider;

  Future<T> update(T t);

  Future<T> insert(T t);

  Future<T> delete(T t);

  Future<List<T>> getAll();
}
