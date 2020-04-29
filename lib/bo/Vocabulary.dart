import 'package:flutterapp/bo/BaseObject.dart';

class Vocabulary extends BaseObject {
  String wordToLearn;
  String reminder;
  String translation;
  bool isArchived;

  Vocabulary(
      [this.wordToLearn,
      this.reminder,
      this.translation,
      this.isArchived = false])
      : super();

  @override
  String toString() {
    return super.toString() +
        "word to learn : $wordToLearn, reminder = $reminder, translation : $translation, is archived : $isArchived";
  }
}
