import 'package:flutter/material.dart';

class VerseAddPage extends StatefulWidget {
  VerseAddPage({Key key}) : super(key: key);

  @override
  _VerseAddPageState createState() => new _VerseAddPageState();
}

class _VerseAddPageState extends State<VerseAddPage> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Add Verse'),),
      body: Text('Add Verse'),
    );
  }
}