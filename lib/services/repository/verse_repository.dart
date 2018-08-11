//TODO: NEXT
import 'dart:async';

import 'package:flutter_emergency_app_one/models/verse.dart';

class VerseRepository {
 
  Future<List<Verse>> getLatestVerses() async {
    return [
      new Verse(
        id: 5,
        content: 'jesus wept',
        isFaved: false,
        dateAdded: '11/10/2018',
        quotation: 'john 11:35',
        categoryId: 2,
      ),
      new Verse(
        id: 6,
        content: 'jesus wept 6',
        isFaved: false,
        dateAdded: '11/10/2018',
        quotation: 'john 11:35',
        categoryId: 2,
      ),
      new Verse(
        id: 7,
        content: 'jesus wept 7',
        isFaved: false,
        dateAdded: '11/10/2018',
        quotation: 'john 11:35',
        categoryId: 1,
      ),
      new Verse(
        id: 8,
        content: 'jesus wept 8',
        isFaved: false,
        dateAdded: '11/10/2018',
        quotation: 'john 11:35',
        categoryId: 3,
      ),
      new Verse(
        id: 9,
        content: 'jesus wept 9',
        isFaved: false,
        dateAdded: '11/10/2018',
        quotation: 'john 11:35',
        categoryId: 1,
      ),
    ];
  }
}
