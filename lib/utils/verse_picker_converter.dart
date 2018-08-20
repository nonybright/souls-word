import 'package:flutter_emergency_app_one/widgets/verse_picker.dart';

VersePickerOptions verseStringToPicker(String verseString) {
  //split  the verse into two, the last seperate part of the fisrt split is the chapter, and the rest is the book
  //split the second part to get the verse begin and verse end. If it has no split, it has only the beginning

  List<String> splitted = verseString.split(':');
  List<String> firstPartSplit = splitted[0].split(' ');
  String chapter = firstPartSplit.last;
  firstPartSplit.removeLast();
  String bookName = firstPartSplit
      .where((val) => val.isNotEmpty)
      .map((ff) => ff.trim())
      .join(' ');
  List<String> secondPartSplit = splitted[1].split('-');
  String startVerse = secondPartSplit[0].trim();
  String endVerse =
      (secondPartSplit.length == 2) ? secondPartSplit[1].trim() : '0';
  return VersePickerOptions(
      bookName, int.parse(chapter), int.parse(startVerse), int.parse(endVerse));
}

String pickerToVerseString(VersePickerOptions pickerOptions) {
  String verseString =
      '${pickerOptions.selectedBook} ${pickerOptions.selectedChapter}:${pickerOptions.startVerse}';
  verseString +=
      (pickerOptions.endVerse != null && pickerOptions.endVerse != 0) ? '-${pickerOptions.endVerse}' : '';
  return verseString;
}
