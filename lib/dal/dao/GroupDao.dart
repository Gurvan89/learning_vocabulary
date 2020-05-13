import 'package:flutterapp/bo/Group.dart';
import 'Dao.dart';

class GroupDao extends Dao<Group> {
  final columnName = 'name';
  final columnDescription = 'decription';
  final columnColor = 'color';
  final columnIcon = 'icon';
  final columnReversed = 'reversed';

  GroupDao();

  @override
  String tableName = "group";

  @override
  String get createTableQuery =>
      "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
      " $columnCreatedAT INTEGER NOT NULL,"
      " $columnUpdatedAT INTEGER NOT NULL,"
      " $columnName TEXT NOT NULL,"
      " $columnDescription TEXT,"
      " $columnColor TEXT,"
      " $columnIcon TEXT,"
      " $columnReversed INTEGER DEFAULT 0 NOT NULL)";

  @override
  Group fromMap(Map<String, dynamic> query) {
    Group g = new Group(
        name: query[columnName],
        description: query[columnDescription],
        color: query[columnColor],
        icon: query[columnIcon],
        isReversed: query[columnReversed] == 1 ? true : false);
    return setBaseObject(g, query);
  }

  @override
  Map<String, dynamic> toMap(Group g) {
    return <String, dynamic>{
      columnUpdatedAT: g.updatedAt.millisecondsSinceEpoch,
      columnCreatedAT: g.createdAt.millisecondsSinceEpoch,
      columnName: g.name,
      columnDescription: g.description,
      columnColor: g.color,
      columnIcon: g.icon,
      columnReversed: g.isReversed ? 1 : 0,
    };
  }

}
