import 'package:flutter/cupertino.dart';
import 'package:flutterapp/bo/BaseObject.dart';

class Vocabulary extends BaseObject {
  String wordToLearn;
  String reminder;
  String translation;
  bool isArchived;
  int groupId;

  Vocabulary(
      {@required this.wordToLearn,
      @required this.reminder,
      @required this.translation,
      this.isArchived = false,
      this.groupId})
      : super();

  @override
  String toString() {
    return super.toString() +
        "word to learn : $wordToLearn, reminder = $reminder, translation : $translation, is archived : $isArchived, groupId :$groupId";
  }
}
