import 'package:flutterapp/bo/BaseObject.dart';

abstract class Dao<T extends BaseObject> {
  final columnId = 'id';
  final columnCreatedAT = 'created_at';
  final columnUpdatedAT = 'updated_at';

  String tableName;

  //queries
  String get createTableQuery;

  //abstract mapping methods
  T fromMap(Map<String, dynamic> query);

  Map<String, dynamic> toMap(T object);

  List<T> fromList(List<Map<String, dynamic>> query) {
    List<T> v = List<T>();
    for (Map map in query) {
      v.add(fromMap(map));
    }
    return v;
  }

  T setBaseObject(T t, Map<String, dynamic> query) {
    t.id = query[columnId];
    t.createdAt = new DateTime.fromMicrosecondsSinceEpoch(query[columnCreatedAT]);
    t.updatedAt = new DateTime.fromMicrosecondsSinceEpoch(query[columnUpdatedAT]);
    return t;
  }
}
