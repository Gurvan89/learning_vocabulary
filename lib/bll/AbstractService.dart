import 'package:flutterapp/bo/BaseObject.dart';
import 'package:flutterapp/dal/dao/Dao.dart';
import 'package:flutterapp/dal/repository/AbstractRepository.dart';

abstract class AbstractService<T extends BaseObject> {

  Future<T> insertOrUpdate(T t);

  void delete(T t);

  Future<List<T>> getAll();
}
