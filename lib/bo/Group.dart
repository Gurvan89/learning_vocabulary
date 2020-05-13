import 'package:flutter/cupertino.dart';
import 'package:flutterapp/bo/BaseObject.dart';
import 'package:flutterapp/bo/Vocabulary.dart';

class Group extends BaseObject {
  String name;
  String description;
  String color;
  String icon;
  bool isReversed;
  List<Vocabulary> vocabularies;

  Group(
      {@required this.name,
      this.description,
      this.color,
      this.icon,
      this.isReversed = false,
      this.vocabularies});

  set addVocabulary(Vocabulary v) => this.vocabularies.add(v);
}
