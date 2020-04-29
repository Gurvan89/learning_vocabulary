import 'package:flutterapp/bll/AbstractService.dart';
import 'package:flutterapp/bo/Vocabulary.dart';
import 'package:flutterapp/dal/DaoFactory.dart';
import 'package:flutterapp/dal/repository/VocabularyRepository.dart';

class VocabularyService implements AbstractService<Vocabulary> {
  VocabularyRepository repository =
      DaoFactory.getFactory(Repositories.vocabulary);

  VocabularyService();

  @override
  void delete(Vocabulary t) {
    repository.delete(t);
  }

  @override
  Future<List<Vocabulary>> getAll() async {
    return await repository.getAll();
  }

  @override
  Future<Vocabulary> insertOrUpdate(Vocabulary t) async {
    if (t.id == null) return repository.insert(t);
    t.updatedAt = DateTime.now();
    return repository.update(t);
  }

  Future<Vocabulary> archive(Vocabulary t) async {
    t.isArchived = true;
    return insertOrUpdate(t);
  }

  Future<Vocabulary> unarchive(Vocabulary t) async {
    t.isArchived = false;
    return insertOrUpdate(t);
  }

  Future<List<Vocabulary>> getAllUnarchived() async {
    return await repository.getAllArchivedOrNot();
  }

  Future<List<Vocabulary>> getAllArchived() async {
    return await repository.getAllArchivedOrNot(isArchived: true);
  }
}
