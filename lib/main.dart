import 'package:flutter/material.dart';

void main() => runApp(new NotepadApp());

class NotepadApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Notepad',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new NotepadListScreen(),
    );
  }
}

class NotepadListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new NotepadListState();
}

class NotepadListState extends State<NotepadListScreen> {
  final List<NotepadListItem> _notes = <NotepadListItem>[];
  final TextEditingController _titleTextController = new TextEditingController();
  final TextEditingController _noteTextController = new TextEditingController();

  void _handlePressed(String title, String body) {
    _titleTextController.clear();
    _noteTextController.clear();
    NotepadListItem item = new NotepadListItem(title: title, body: body);
    setState(() {
      _notes.add(item);
    });
    Navigator.of(context).pop();
  }

  void _pushNewNote() {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('New Note'),
          ),
          body: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.all(16.0),
                child: new TextField(
                    controller: _titleTextController,
                    decoration: new InputDecoration.collapsed(
                      hintText: 'Title',
                      hintStyle: new TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF737171)
                      ),
                    )
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                child: new TextField(
                    controller: _noteTextController,
                    decoration: new InputDecoration.collapsed(
                      hintText: 'Note',
                      hintStyle: new TextStyle(
                          fontSize: 14.0,
                          color: const Color(0xFF737171)
                      ),
                    )
                ),
              )
            ],
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: () => _handlePressed(_titleTextController.text, _noteTextController.text),
            child: new Icon(Icons.check),
          ),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('Notepad')),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemBuilder: (_, int index) => _notes[index],
              itemCount: _notes.length,
            ))
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushNewNote,
        child: new Icon(Icons.add),
      ),
    );
  }
}

class NotepadListItem extends StatelessWidget {
  NotepadListItem({this.title, this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.all(5.0),
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.all(16.0),
              child: new Text(this.title,
                style: new TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
                )
              )
            ),
            new Container(
              margin: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: new Text(this.body,
                style: new TextStyle(
                  fontSize: 14.0
                )
              )
            )
          ],
        ),
      )
    );
  }

}