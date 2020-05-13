import 'package:flutter/material.dart';
import 'package:flutterapp/bo/Vocabulary.dart';

class VocabularyCard extends StatelessWidget {
  final bool enabled;

  final Vocabulary vocabulary;

  VocabularyCard(this.vocabulary, {this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(vocabulary.wordToLearn),
            subtitle: Text(vocabulary.lastUpdatedAtToString,
                style: TextStyle(fontSize: 9)),
            enabled: enabled,
            onTap: () => _showToast(context, vocabulary.reminder),
            onLongPress: () => _showToast(context, vocabulary.translation),
          )
        ],
      ),
    );
  }

  static void _showToast(BuildContext context, String translation) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(translation),
        action: SnackBarAction(
            label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
