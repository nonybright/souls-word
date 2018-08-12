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

// import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
// import 'package:flutter_emergency_app_one/redux/verse/verse_actions.dart';
// import 'package:flutter_emergency_app_one/redux/verse/verse_middleware.dart';
// import 'package:flutter_emergency_app_one/services/local/category_local.dart';
// import 'package:flutter_emergency_app_one/services/local/verse_local.dart';
// import 'package:flutter_emergency_app_one/services/repository/verse_repository.dart';
// import 'package:flutter_emergency_app_one/models/verse_category.dart';
// import 'package:flutter_emergency_app_one/redux/app/app_reducer.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:redux/redux.dart';

// void main() {
//   MockVerseRepository verseRepository =  MockVerseRepository();
//   MockVerseLocal verseLocal = MockVerseLocal();
//   MockCategoryLocal categoryLocal = MockCategoryLocal();
//   List<dynamic> actions = [];
//   setUp(() {
//     when(categoryLocal.getCategories()).thenAnswer((inv) => [
//       VerseCategory(id: 1, name: 'Church', description: 'church', isDefault: true),
//       VerseCategory(id: 2, name: 'Command', description: 'church', isDefault: true),
//       VerseCategory(id: 1, name: 'Last', description: 'church', isDefault: true),
//     ]);
//   });

//   tearDown((){
//         actions.clear();
//   });

//   test('repo', () async {
//     List<Middleware<AppState>> middleWares =
//         createVerseMiddleWare(verseRepository, verseLocal, categoryLocal);

//      Store<AppState> store = Store(
//         appReducer,
//         initialState: AppState.initial(),
//         middleware: middleWares
//     );

//       await middleWares[1].call(store, GetVerseCategoryAction() , (action){

//             actions.add(action);
//             print('next called');
//             if(action is VerseCategorySuccessfulAction){
//               action.verseCategories;
//             }
//       });

//     //store.dispatch(GetVerseCategoryAction());

//     verify(categoryLocal.getCategories()).called(2);

//     // expectLater([
//     //   VerseCategory(id: 1, name: 'Church', description: 'church', isDefault: true),
//     //   VerseCategory(id: 2, name: 'Command', description: 'church', isDefault: true),
//     //   VerseCategory(id: 1, name: 'Last', description: 'church', isDefault: true),
//     // ], store.state.verseState.verseCategories);

//     //  expectLater(store.state.verseState.verseCategories, [
//     //   VerseCategory(id: 1, name: 'Church', description: 'church', isDefault: true),
//     //   VerseCategory(id: 2, name: 'Command', description: 'church', isDefault: true),
//     //   VerseCategory(id: 1, name: 'Last', description: 'church', isDefault: true),
//     // ]);

//   });
// }

// class MockVerseRepository extends Mock implements VerseRepository {}

// class MockVerseLocal extends Mock implements VerseLocal {}

// class MockCategoryLocal extends Mock implements CategoryLocal {}
