import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/bo/Vocabulary.dart';
import '../tools/Extensions.dart';

class VocabularyForm extends StatefulWidget {
  final ValueChanged<Vocabulary> updateVoc;

  final closeDialog;

  final Vocabulary vocabulary;

  const VocabularyForm(
      {Key key, this.updateVoc, this.closeDialog, this.vocabulary})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VocabularyFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class VocabularyFormState extends State<VocabularyForm> {
  final _formKey = GlobalKey<FormState>();

  static const String EMPTY_FIELD = "There's something missing here.";

  Vocabulary _v;

  @override
  Widget build(BuildContext context) {
    if (widget.vocabulary == null)
      _v = new Vocabulary();
    else
      _v = widget.vocabulary;
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            initialValue: _v.wordToLearn,
            decoration: InputDecoration(hintText: "Vocabulary to learn ?"),
            autofocus: true,
            validator: (value) {
              if (value.isEmpty) return EMPTY_FIELD;
              _v.wordToLearn = value.capitalize();
              return null;
            },
          ),
          TextFormField(
            initialValue: _v.reminder,
            maxLines: 5,
            decoration: InputDecoration(
                hintText: "Example/reminder"),
            validator: (value) {
              if (value.isEmpty) return EMPTY_FIELD;
              _v.reminder = value.capitalize();
              return null;
            },
          ),
          TextFormField(
            initialValue: _v.translation,
            decoration: InputDecoration(hintText: "Translation"),
            validator: (value) {
              if (value.isEmpty) return EMPTY_FIELD;
              _v.translation = value.capitalize();
              return null;
            },
          ),
          Row(
            children: <Widget>[
              IconButton(
                alignment: Alignment.bottomLeft,
                onPressed: () {
                  widget.closeDialog();
                },
                icon: new Icon(Icons.close),
              ),
              IconButton(
                alignment: Alignment.bottomRight,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    widget.updateVoc(_v);
                  }
                },
                icon: widget.vocabulary == null
                    ? new Icon(Icons.add_circle)
                    : new Icon(Icons.update),
              )
            ],
          )
        ]));
  }
}
