import 'package:flutter/material.dart';
import 'package:flutterapp/bll/VocabularyService.dart';
import 'package:flutterapp/bo/Vocabulary.dart';
import 'VocabularyCard.dart';
import 'VocabularyForm.dart';

class VocabulariesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _VocabulariesPageState();
  }
}

class _VocabulariesPageState extends State<VocabulariesPage> {
  static VocabularyService vocabularyService = new VocabularyService();
  int currentIndex;
  List<Vocabulary> vocabularyList;
  List<Vocabulary> archivedList;
  bool isInit = false;

  @override
  void initState() {
    super.initState();
    vocabularyService.getAllUnarchived().then((list) => setState(() {
          vocabularyList = list;
        }));
    vocabularyService.getAllArchived().then((list) => setState(() {
          archivedList = list;
        }));
  }

  Widget _buildVocabulariesList({bool isArchived = false}) {
    List<Vocabulary> _currentList = isArchived ? archivedList : vocabularyList;
    if (_currentList == null) return Center(child: Text("Loading..."));
    return Container(
        child: _currentList.length > 0
            ? ListView.builder(
                itemCount: _currentList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    movementDuration: const Duration(milliseconds: 500),
                    onDismissed: (DismissDirection direction) {
                      if (isArchived)
                        this._onDismissedArchived(direction, index);
                      else
                        this._onDismissedUnarchived(direction, index);
                    },
                    secondaryBackground: Container(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                                isArchived ? Icons.delete : Icons.archive,
                                color: Colors.white)),
                      ),
                      color: isArchived ? Colors.red : Colors.brown,
                    ),
                    background: Container(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                  isArchived ? Icons.unarchive : Icons.edit,
                                  color: Colors.white))),
                      color: isArchived ? Colors.lightGreen : Colors.blueAccent,
                    ),
                    child: VocabularyCard(_currentList[index],
                        enabled: !isArchived),
                    key: UniqueKey(),
                    direction: DismissDirection.horizontal,
                  );
                })
            : Center(child: Text('No Items')));
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("Vocabulary list"),
            bottom: TabBar(
              tabs: [
                Tab(text: "To learn", icon: Icon(Icons.format_list_bulleted)),
                Tab(text: "Already learned", icon: Icon(Icons.archive)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildVocabulariesList(),
              _buildVocabulariesList(isArchived: true),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            mini: true,
            onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Learn a new word"),
                    content: VocabularyForm(
                      updateVoc: _updateV,
                      closeDialog: _closeDialog,
                    ),
                  );
                }),
            tooltip: 'Add new vocabulary',
            child: Icon(Icons.add),
          ),
        ));
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }

  void _updateV(Vocabulary v) {
    vocabularyService.insertOrUpdate(v);
    if (v.id != null) {
      vocabularyList[currentIndex] = v;
    } else {
      vocabularyList.add(v);
    }
    setState(() {});
    _closeDialog();
  }

  void _onDismissedUnarchived(DismissDirection direction, int index) {
    if (direction == DismissDirection.endToStart) {
      setState(() {
        vocabularyService.archive(vocabularyList[index]);
        archivedList.add(vocabularyList[index]);
        vocabularyList.removeAt(index);
      });
    }
    if (direction == DismissDirection.startToEnd) {
      currentIndex = index;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Update your word"),
              content: VocabularyForm(
                updateVoc: _updateV,
                closeDialog: _closeDialog,
                vocabulary: vocabularyList[index],
              ),
            );
          });
      setState(() {});
    }
  }

  void _onDismissedArchived(DismissDirection direction, int index) {
    if (direction == DismissDirection.endToStart) {
      setState(() {
        vocabularyService.delete(archivedList[index]);
      });
    }
    if (direction == DismissDirection.startToEnd) {
      setState(() {
        vocabularyService.unarchive(archivedList[index]);
        vocabularyList.add(archivedList[index]);
      });
    }
    archivedList.removeAt(index);
  }
}
