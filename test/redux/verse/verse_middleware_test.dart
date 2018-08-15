import 'dart:async';

import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/models/verse_category.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_actions.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_middleware.dart';
import 'package:flutter_emergency_app_one/services/local/category_local.dart';
import 'package:flutter_emergency_app_one/services/local/verse_local.dart';
import 'package:flutter_emergency_app_one/services/repository/verse_repository.dart';
import 'package:flutter_emergency_app_one/redux/app/app_reducer.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

void main() {
  List<dynamic> actions = [];
  MockVerseRepository verseRepository;
  MockVerseLocal verseLocal;
  MockCategoryLocal categoryLocal;
  Function next = (action) => actions.add(action);

  VerseMiddleWare verseMiddleWare;
  
  setUp(() {

    verseRepository = MockVerseRepository();
    verseLocal = MockVerseLocal();
    categoryLocal = MockCategoryLocal();

    verseMiddleWare =
        VerseMiddleWare(verseRepository, verseLocal, categoryLocal);

    when(categoryLocal.getCategories()).thenAnswer((_) => new Future.value([
          VerseCategory(
              id: 1, name: 'Church', description: 'church', isDefault: true),
          VerseCategory(
              id: 2, name: 'Command', description: 'church', isDefault: true),
          VerseCategory(
              id: 1, name: 'Last', description: 'church', isDefault: true),
        ]));
  });

  tearDown(() {
    actions.clear();
  });

  test('Request categories from Local Repository', () async {
  
    Store<AppState> store = Store(appReducer,
        initialState: AppState.initial(),
        );
    await verseMiddleWare.call(store, GetVerseCategoryAction(), next);
    verify(categoryLocal.getCategories());

  });

  test('Saves category when saveCategoryaction is dispatched and calls successful when done', () async {

        when(categoryLocal.addCategory(typed(any))).thenAnswer((_) => null);
        when(categoryLocal.updateCategory(typed(any))).thenAnswer((_) => null);

        VerseCategory catWithId = VerseCategory(id: 1, name: 'cat', dateAdded: DateTime.now(), isDefault: false, description: 'description');
        VerseCategory catWithOutId = VerseCategory(name: 'cat2', dateAdded: DateTime.now(), isDefault: false, description: 'description');

        Store<AppState> store = Store(appReducer,
        initialState: AppState.initial(),
        );

        final Completer<Null> completer = new Completer<Null>();
        await verseMiddleWare.call(store, AddVerseCategory(catWithId, completer), next);
        verify(categoryLocal.updateCategory(typed(any)));
        expect(actions[1], const isInstanceOf<VerseCategoryAddSuccessfulAction>());

        actions.clear();

         final Completer<Null> completer2 = new Completer<Null>();
        await verseMiddleWare.call(store, AddVerseCategory(catWithOutId, completer2), next);
        verify(categoryLocal.addCategory(typed(any)));
        expect(actions[1], const isInstanceOf<VerseCategoryAddSuccessfulAction>());


  });

  test(
      'when get latest categories called, should dispatch successful with latest categories gotten',
      () async {
    List<Verse> latestVerses = [
      new Verse(
        id: 7,
        content: 'jesus wept 7',
        isFaved: false,
        dateAdded: DateTime.now(),
        quotation: 'john 11:35',
        categoryId: 1,
      ),
      new Verse(
        id: 8,
        content: 'jesus wept 8',
        isFaved: false,
        dateAdded: DateTime.now(),
        quotation: 'john 11:35',
        categoryId: 3,
      )
    ];

    when(verseRepository.getLatestVerses()).thenAnswer((_)=> new Future.value(latestVerses));

    Store<AppState> store = Store(appReducer,
        initialState: AppState.initial(),
        );
    await verseMiddleWare.call(store, LatestVerseAction(), next);

    verify(verseRepository.getLatestVerses());
    expect(actions[1], const isInstanceOf<LatestVerseSuccessfulAction>());
    expect(actions[1].verses, latestVerses);
  });

  test('Verse favorite toggled to a different state and changed in local repository', ()async{

      Verse verse = Verse(
        id: 8,
        content: 'jesus wept 8',
        isFaved: false,
        dateAdded: DateTime.now(),
        quotation: 'john 11:35',
        categoryId: 2,
        isDefault: false
      );

      when(verseLocal.updateVerse(typed(any))).thenAnswer((_)=> Future.value(1));
        Store<AppState> store = Store(appReducer,
            initialState: AppState.initial(),
          );
    
    await verseMiddleWare.call(store, ToggleVerseFavoriteAction(verse), next);

    verify(verseLocal.updateVerse(typed(any)));
    expect(actions[1], const isInstanceOf<ToggleVerseFavoriteSuccessFulAction>());
    expect(actions[1].toggledVerse.isFaved, true);
    
  });
}

class MockVerseRepository extends Mock implements VerseRepository {}
class MockVerseLocal extends Mock implements VerseLocal {}
class MockCategoryLocal extends Mock implements CategoryLocal {}