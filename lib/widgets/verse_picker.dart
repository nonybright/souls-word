import 'package:flutter/material.dart';
import 'package:flutter_emergency_app_one/models/BibleBook.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/utils/verse_picker_converter.dart';
import 'package:flutter_redux/flutter_redux.dart';

class VersePickerOptions {
  String selectedBook;
  int selectedChapter;
  int startVerse;
  int endVerse;

  VersePickerOptions(
      [this.selectedBook,
      this.selectedChapter,
      this.startVerse,
      this.endVerse]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VersePickerOptions &&
          selectedBook == other.selectedBook &&
          selectedChapter == other.selectedChapter &&
          startVerse == other.startVerse &&
          endVerse == other.endVerse;

  @override
  int get hashCode =>
      selectedBook.hashCode ^
      selectedChapter.hashCode ^
      startVerse.hashCode ^
      endVerse.hashCode;
}

class BibleVersePicker extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final VersePickerOptions versePickerOptions;
  final String verseString;
  BibleVersePicker(
      {Key key, this.onChanged, this.versePickerOptions, this.verseString})
      : super(key: key);

  @override
  _BibleVersePickerState createState() => new _BibleVersePickerState();
}

class _BibleVersePickerState extends State<BibleVersePicker> {
  VersePickerOptions pickerOptions;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<BibleBook>>(
      // TODO: Implement == and hashcode and set distinct to true;
      converter: (store) => store.state.bibleBooks,
      builder: (_, bibleBooks) {
        return BibleVersePickerContent(
          bibleBooks: bibleBooks,
          versePickerOptions: widget.versePickerOptions,
          verseString: widget.verseString,
          onChanged: widget.onChanged,
        );
      },
    );
  }
}

class BibleVersePickerContent extends StatefulWidget {
  final List<BibleBook> bibleBooks;
  final VersePickerOptions versePickerOptions;
  final String verseString;
  final ValueChanged<String> onChanged;

  BibleVersePickerContent(
      {Key key,
      this.bibleBooks,
      this.versePickerOptions,
      this.verseString,
      this.onChanged})
      : super(key: key);

  @override
  _BibleVersePickerContentState createState() =>
      new _BibleVersePickerContentState();
}

class _BibleVersePickerContentState extends State<BibleVersePickerContent> {
  VersePickerOptions versePickerOptions;
  List<BibleBook> books;
  ValueChanged<String> onChanged;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    books = widget.bibleBooks;
    onChanged = widget.onChanged;
    if (widget.versePickerOptions != null) {
      versePickerOptions = widget.versePickerOptions;
    } else if (widget.verseString != null) {
      versePickerOptions = verseStringToPicker(widget.verseString);
    } else {
      versePickerOptions = new VersePickerOptions('Genesis', 1, 1, 0);
    }
    //changeVerseString();
  }

  @override
  Widget build(BuildContext context) {
    List<String> bookNames =
        widget.bibleBooks.map((book) => book.name).toList();

    new List.generate(
        widget.bibleBooks
            .firstWhere((book) => book.name == versePickerOptions.selectedBook)
            .chapters,
        (chapter) => chapter).toList();
    return Column(
      children: <Widget>[
        DropdownButton<String>(
            value: versePickerOptions.selectedBook,
            items: bookNames.map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (book) {
              setState(() {
                versePickerOptions = new VersePickerOptions(book, 1, 1, 0);
                changeVerseString();
              });
            }),
        DropdownButton<String>(
            value: versePickerOptions.selectedChapter.toString(),
            items: bookMaxChapterList().map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (chapter) {
              setState(() {
                versePickerOptions.selectedChapter = int.parse(chapter);
                changeVerseString();
              });
            }),
        DropdownButton<String>(
            value: versePickerOptions.startVerse.toString(),
            items: chapterMaxVerseCountList().map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (verse) {
              setState(() {
                versePickerOptions.startVerse = int.parse(verse);
                changeVerseString();
                
              });
            }),
        DropdownButton<String>(
            value: versePickerOptions.endVerse.toString(),
            items: chapterMaxVerseCountList(true).map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (verse) {
              setState(() {
                versePickerOptions.endVerse = int.parse(verse);
                changeVerseString();
              });
            })
      ],
    );
  }

  void changeVerseString() {
    onChanged(pickerToVerseString(versePickerOptions));
  }

  List<String> bookMaxChapterList() {
    BibleBook theBook = getSelectedBibleBook();

    List<String> val = List<String>.generate(
        theBook.chapters, (chapter) => (chapter + 1).toString()).toList();
    return val;
  }

  List<String> chapterMaxVerseCountList([bool isEndVerseButton = false]) {
    BibleBook theBook = getSelectedBibleBook();
    List<String> val;

    if(isEndVerseButton){
        val = List<String>.generate(
        theBook.maxVerse + 1, (verse) => (verse).toString()).toList();
    }else{
      val = List<String>.generate(
        theBook.maxVerse, (verse) => (verse + 1).toString()).toList();
    }
    return val;
  }

  BibleBook getSelectedBibleBook() {
    return books
        .firstWhere((book) => book.name == versePickerOptions.selectedBook);
  }
}
