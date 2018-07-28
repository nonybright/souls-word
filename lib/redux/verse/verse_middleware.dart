//import 'dart:async';
import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_view_page.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_actions.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_selectors.dart';
import 'package:flutter_emergency_app_one/services/local/category_local.dart';
import 'package:flutter_emergency_app_one/services/local/database_helper.dart';
import 'package:flutter_emergency_app_one/services/local/verse_local.dart';
import 'package:flutter_emergency_app_one/services/repository/verse_repository.dart';

List<Middleware<AppState>> createVerseMiddleWare() {
  VerseRepository _verseRepo = VerseRepository();

  DatabaseHelper dbHelper = new DatabaseHelper();

  VerseLocal _verseLocal = VerseLocal(dbHelper);
  CategoryLocal _categoryLocal = CategoryLocal(dbHelper);

  return [
    new TypedMiddleware<AppState, LatestVerseAction>(
        _getLatestVerses(_verseRepo)),
    new TypedMiddleware<AppState, GetVerseCategoryAction>(
        _getCategories(_categoryLocal)),
    new TypedMiddleware<AppState, GetCurrentVersesAction>(
        _getCurrentVerses(_verseLocal)),
    //new TypedMiddleware<AppState, GetAllVersesAction>(
    //    _getAllVerses(_verseLocal)),
    new TypedMiddleware<AppState, ToggleVerseFavoriteAction>(
        _toggleVerseFavorite(_verseLocal)),
    // new TypedMiddleware<AppState, GetCategoryVerseAndFavAction>(
    //    _getCategoryVerseAndFav()),
  ];
}

/*Middleware<AppState> _getCategoryVerseAndFav() {
  return (Store store, action, NextDispatcher next) {
    if (action is GetCategoryVerseAndFavAction) {
      next(GetCurrentVersesAction(1, VerseDisplayType.category,
          action: null, categoryID: action.categoryId));

      //next(GetCurrentVersesAction(1, VerseDisplayType.favorite,
      //    action: null, categoryID: action.categoryId));
    }
    next(action);
  };
}*/

Middleware<AppState> _toggleVerseFavorite(VerseLocal verseLocal) {
  return (Store store, action, NextDispatcher next) {
    if (action is ToggleVerseFavoriteAction) {
      Verse toggledVerse =
          action.verseToToggle.copyWith(isFaved: !action.verseToToggle.isFaved);
      verseLocal.updateVerse(toggledVerse).then(
          (val) => next(ToggleVerseFavoriteSuccessFulAction(toggledVerse)));
    }
    next(action);
  };
}

Middleware<AppState> _getCategories(CategoryLocal categoryLocal) {
  return (Store store, action, NextDispatcher next) {
    categoryLocal
        .getCategories()
        .then((categories) => next(VerseCategorySuccessfulAction(categories)))
        .catchError((error) => next(action));

    next(action);
  };
}

Middleware<AppState> _getCurrentVerses(VerseLocal verseLocal) {
  return (Store store, action, NextDispatcher next) async {
    //if page = 1;  // clear previous verses action
    //if totalPage != null, use totalPage, else get total Page and dispatch // jus like with the get verse local and then
    //if categoryID is not set, getAll --- if categoryID is set, dispatch both, else dispatch currentFavSuccesful too.

    int perPage = 50;
    int offset = (action.currentPage - 1) * perPage;

    if (action is GetCurrentVersesAction) {
      // if (action.type == VerseDisplayType.category) {
      //   for (int i = 53; i < 550; i++) {
      //     await verseLocal.insert(new Verse(
      //       id: i,
      //       content: 'content $i',
      //       quotation: 'mathew 5 $i',
      //       isFaved: false,
      //       dateAdded: "$i",
      //       categoryId: 1,
      //       isDefault: true,
      //     ));
      //     print(i);
      //   }
      // }
      if (action.currentPage == 1 || action.currentPage == null) {
        if (action.type == VerseDisplayType.category) {
          next(
              ClearCurrentVersesDetailsAction()); //get general currentLoading to true
        } else {
          next(ClearCurrentFavoriteDetailsAction());
        }
      }
      int totalPage = 0;
      if (totalPagesSelector(store.state, action.type) != null) {
        totalPage = totalPagesSelector(
            store.state,
            VerseDisplayType
                .category); //TODO: refactor this block out if not needed.
      } else {
        int totalRows = await verseLocal.getVersesCount(action.type,
            categoryId: action.categoryID);
        int totalPages = (totalRows / perPage).ceil();
        if (action.type == VerseDisplayType.category) {
          next(SetCurrentVersePagesAction(totalPages));
        } else {
          next(SetCurrentFavoritePagesAction(totalPages));
        }
      }

      List<Verse> verses = await verseLocal.getVerses(action.type,
          action: action.action,
          limit: perPage,
          offset: offset,
          categoryId: action.categoryID);

      if (action.type == VerseDisplayType.category) {
        next(CurrentVersesSuccessfulAction(verses));
      } else {
        next(CurrentFavSuccessfulAction(verses));
      }
    }

    next(action);

    /*if (action is GetCurrentVersesAction) {
      Future.wait([
        verseLocal.getVerses(VerseDisplayType.category, action.action,
            categoryId: action.categoryID),
        verseLocal.getVerses(VerseDisplayType.favorite, action.action,
            categoryId: action.categoryID)
      ]).then((result) {
        next(CurrentVersesSuccessfulAction(result[0]));
        next(CurrentFavSuccessfulAction(result[1]));
      }).catchError((error) => next(action));
    }
    next(action);*/
  };
}

/*Middleware<AppState> _getAllVerses(VerseLocal verseLocal) {
  return (Store store, action, NextDispatcher next) {
    if (action is GetAllVersesAction) {
      //records per

      int perPage = 50;

      int offset = (action.currentPage - 1) * perPage;
      int totalRows = 10; // get from the local
      int totalPages = (totalRows / perPage).ceil();
      //dispatch totalPages when it is gotten to the state so
      //that it can be used in the verse_view_viewModel
      if (action.type == VerseDisplayType.category) {
        verseLocal
            .getVerses(action.type, action.action)
            .then((catVerse) => next(CurrentVersesSuccessfulAction(catVerse)));
      } else {
        verseLocal
            .getVerses(action.type, action.action)
            .then((favVerse) => next(CurrentFavSuccessfulAction(favVerse)));
      }
    }
    next(action);
  };
}*/

Middleware<AppState> _getLatestVerses(VerseRepository verseRepo) {
  return (Store store, action, NextDispatcher next) {
    //get from repo
    List<Verse> gottenVerses = [
      new Verse(
        id: 5,
        content: 'jesus wept',
        isFaved: false,
        dateAdded: '11/10/2018',
        quotation: 'john 11:35',
        categoryId: 1,
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
    //this is actually done if all is well
    next(LatestVerseSuccessfulAction(gottenVerses));
  };
}
