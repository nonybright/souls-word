import 'package:flutter_emergency_app_one/models/BibleBook.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/app/biblebook/bible_book_action.dart';
import 'package:flutter_emergency_app_one/redux/app/app_reducer.dart';
import 'package:flutter_emergency_app_one/redux/app/biblebook/bible_book_middleware.dart';
import 'package:flutter_emergency_app_one/services/local/bible_book_local.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

void main() {
  List<dynamic> actions = [];
  Function next = (action) => actions.add(action);

  MockBibleBookLocal bibleBookLocal;
  BibleBookMiddleWare bibleBookMiddleWare;
  
  setUp(() {

    bibleBookLocal = MockBibleBookLocal();
    bibleBookMiddleWare = BibleBookMiddleWare(bibleBookLocal);

    when(bibleBookLocal.getBooks()).thenAnswer((_) => new Future.value([

      BibleBook(id: 1, name: 'Genesis', chapters: 44, maxVerse: 22, testament: 1),
      BibleBook(id: 2, name: 'Exodus', chapters: 10, maxVerse: 19, testament: 1),
      BibleBook(id: 3, name: 'Levinticus', chapters: 19, maxVerse: 41, testament: 1),
      BibleBook(id: 4, name: 'Mathew', chapters: 15, maxVerse: 13, testament: 2),
      BibleBook(id: 5, name: 'Mark', chapters: 21, maxVerse: 10, testament: 2),
      BibleBook(id: 6, name: '1 Peter', chapters: 0, maxVerse: 10, testament: 2),

    ]));

  });

  tearDown(() {
    actions.clear();
  });

  

  test('Gets bibleVerses List when GetBibleBooksAction call getBooks from repository and dispatch GetBibleBooksSuccessfulAction', () async {
  
    Store<AppState> store = Store(appReducer,
        initialState: AppState.initial(),
        );
    await bibleBookMiddleWare.call(store, GetBibleBooksAction(), next);
    verify(bibleBookLocal.getBooks());
    expect(actions[1], const isInstanceOf<GetBibleBooksSuccessfulAction>());
    expect(actions[1].gottenBooks[0].name, 'Genesis');
  });

}

class MockBibleBookLocal extends Mock implements BibleBookLocal {}