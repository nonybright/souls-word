import 'package:flutter/material.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_add_view_model.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/utils/verse_parser.dart';
import 'package:flutter_emergency_app_one/widgets/verse_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;

class VerseAddPage extends StatefulWidget {
  VerseAddPage({Key key}) : super(key: key);

  @override
  _VerseAddPageState createState() => new _VerseAddPageState();
}

class _VerseAddPageState extends State<VerseAddPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VerseAddViewModel>(
      // TODO: Implement == and hashcode and set distinct to true;
      converter: (store) => VerseAddViewModel.fromStore(store),
      builder: (_, viewModel) {
        return new Scaffold(
          appBar: AppBar(
            title: Text('Add Verse'),
          ),
          body: VerseAddContent(viewModel.addVerse),
        );
      },
    );
  }
}

class VerseAddContent extends StatefulWidget {
  final Verse verseToEdit;
  final Function(Verse) addVerse;
  VerseAddContent(this.addVerse, {Key key, this.verseToEdit}) : super(key: key);

  @override
  _VerseAddContentState createState() => new _VerseAddContentState();
}

class _VerseAddContentState extends State<VerseAddContent> {
  final formKey = GlobalKey<FormState>();
  String theVerseString = '';
  TextEditingController verseContentController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theVerseString = 'Genesis 1:1';
    verseContentController = TextEditingController(text:  widget.verseToEdit?.content);

  }

  @override
  Widget build(BuildContext context) {
    return Form(
            key: formKey,
          child: Column(
        children: <Widget>[
          TextField(
            controller: verseContentController,
          ),
          RaisedButton(
            child: Text('GET VERSE ONLINE'),
            onPressed: () {

              _getOnlineVerse(theVerseString);
            },
          ),
          RaisedButton(
            child: Text('SAVE VERSE'),
            onPressed: () {
              //TODONOW: add select for the categoryId
              _submit(verseContentController.text, theVerseString, 1);
            },
          ),
          Text(theVerseString),
          BibleVersePicker(
            verseString: (widget.verseToEdit != null) ? widget.verseToEdit.quotation: theVerseString,
            onChanged: (verseString) {
              setState(() {
                this.theVerseString = verseString;
              });
            },
          ),
        ],
      ),
    );
  }

  void _getOnlineVerse(String theVerseString) async {
    VerseParser verseParser = VerseParser(http.Client());
    List<String> verses = await verseParser.parse(theVerseString);
    verseContentController.text = verses.join('\n');
  }

  void _submit(String content, String quotation , int categoryId) {
    
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      if ( widget.verseToEdit != null) {
        widget.verseToEdit.content = content;
        widget.verseToEdit.quotation = quotation;
        widget.verseToEdit.categoryId = categoryId;
        widget.addVerse(widget.verseToEdit);
      } else {
        Verse verseToAdd = Verse(
            content: content, quotation: quotation, categoryId: categoryId);
        widget.addVerse(verseToAdd);
      }
    }
  }
}
