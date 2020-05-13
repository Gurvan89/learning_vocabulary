import 'package:flutterapp/bo/Vocabulary.dart';
import 'package:flutterapp/dal/dao/GroupDao.dart';
import 'Dao.dart';

class VocabularyDao extends Dao<Vocabulary> {
  final columnWordToLearn = 'word_to_learn';
  final columnReminder = 'reminder';
  final columnTranslation = 'translation';
  final columnIsArchived = 'is_archived';
  final columnGroupId = 'group_id';

  VocabularyDao();

  @override
  String tableName = "vocabulary";

  @override
  String get createTableQuery =>
      "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
      " $columnCreatedAT INTEGER NOT NULL,"
      " $columnUpdatedAT INTEGER NOT NULL,"
      " $columnWordToLearn TEXT NOT NULL,"
      " $columnReminder TEXT NOT NULL,"
      " $columnIsArchived INTEGER DEFAULT 0 NOT NULL,"
      " $columnTranslation TEXT NOT NULL,"
      " $columnGroupId INTEGER"
      "FOREIGN KEY($columnGroupId) REFERENCES group(id))";

  int now = DateTime.now().millisecondsSinceEpoch;

  String get insert => "INSERT "
      "INTO $tableName ($columnCreatedAT,$columnUpdatedAT,$columnWordToLearn,$columnReminder,$columnTranslation) "
      "VALUES"
      "($now,	$now ,'Surgeon','Kind of doctor','Chirurgien'),"
      "($now,	$now ,'Basement','I keep my tools in the basement (underneath the house)','Sous-sol'),"
      "($now,	$now ,'Stream','He turned on the tap and a stream of water came out.','Flux'),"
      "($now,	$now ,'Shape','Sqare, circle, triangle, ...','Une forme'),"
      "($now,	$now ,'Thick','This mattress is thick','Epais'),"
      "($now,	$now ,'Sibling','Brothers & sisters','Frères et Soeurs'),"
      "($now,	$now ,'To sigh','I breathed a sigh of relief when the plane landed.','Soupirer'),"
      "($now,	$now ,'Stare','She tried hard not to stare at the men.','Regard fixe')";

  @override
  Vocabulary fromMap(Map<String, dynamic> query) {
    Vocabulary v = new Vocabulary(
        wordToLearn: query[columnWordToLearn],
        reminder: query[columnReminder],
        translation: query[columnTranslation],
        groupId: query[columnGroupId],
        isArchived: query[columnIsArchived] == 1 ? true : false);
    return setBaseObject(v, query);
  }

  @override
  Map<String, dynamic> toMap(Vocabulary v) {
    return <String, dynamic>{
      columnWordToLearn: v.wordToLearn,
      columnReminder: v.reminder,
      columnTranslation: v.translation,
      columnUpdatedAT: v.updatedAt.millisecondsSinceEpoch,
      columnCreatedAT: v.createdAt.millisecondsSinceEpoch,
      columnGroupId: v.groupId,
      columnIsArchived: v.isArchived ? 1 : 0,
    };
  }
}
