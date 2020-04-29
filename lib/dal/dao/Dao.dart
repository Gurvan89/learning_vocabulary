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

  List<T> fromList(List<Map<String, dynamic>> query);

  Map<String, dynamic> toMap(T object);
}
