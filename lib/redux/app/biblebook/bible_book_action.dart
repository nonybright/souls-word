import 'package:flutter_emergency_app_one/models/BibleBook.dart';

class GetBibleBooksAction{
    GetBibleBooksAction();
}

class GetBibleBooksSuccessfulAction{

    List<BibleBook> gottenBooks;
    GetBibleBooksSuccessfulAction(this.gottenBooks);
}