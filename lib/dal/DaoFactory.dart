import 'package:flutterapp/dal/DatabaseProvider.dart';
import 'package:flutterapp/dal/repository/AbstractRepository.dart';
import 'package:flutterapp/dal/repository/VocabularyRepository.dart';

enum Repositories { vocabulary }

class DaoFactory {
  static AbstractRepository getFactory(Repositories r) {
    AbstractRepository repository;
    switch (r) {
      case Repositories.vocabulary:
        repository = VocabularyRepository(DatabaseProvider.get);
        break;
    }
    return repository;
  }
}
