import 'package:flutterapp/bo/Vocabulary.dart';
import 'package:flutterapp/dal/dao/VocabularyDao.dart';
import 'package:flutterapp/dal/repository/AbstractRepository.dart';
import 'package:flutterapp/dal/DatabaseProvider.dart';

class VocabularyRepository
    extends AbstractRepository<Vocabulary, VocabularyDao> {
  VocabularyRepository(DatabaseProvider databaseProvider)
      : super(databaseProvider, new VocabularyDao());

  Future<List<Vocabulary>> getAllArchivedOrNot(
      {bool isArchived = false}) async {
    final db = await databaseProvider.db();
    String _columnIsArchived = dao.columnIsArchived;
    int isArchivedInt = isArchived ? 1 : 0;
    List<Map> maps = await db.query(dao.tableName,
        where: "$_columnIsArchived = $isArchivedInt");
    return dao.fromList(maps);
  }
}
