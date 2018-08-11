//import 'dart:async';
import 'dart:async';

import 'package:flutter_emergency_app_one/models/verse_category.dart';
import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_view_page.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_actions.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_selectors.dart';
import 'package:flutter_emergency_app_one/services/local/category_local.dart';
import 'package:flutter_emergency_app_one/services/local/verse_local.dart';
import 'package:flutter_emergency_app_one/services/repository/verse_repository.dart';

class VerseMiddleWare extends MiddlewareClass<AppState> {
  VerseRepository verseRepository;
  VerseLocal verseLocal;
  CategoryLocal categoryLocal;

  VerseMiddleWare(this.verseRepository, this.verseLocal, this.categoryLocal);

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is GetVerseCategoryAction) {
      await _getCategories(action, next);
    } else if (action is LatestVerseAction) {
      await _getLatestVerses(next);
    } else if (action is ToggleVerseFavoriteAction) {
      await _toggleVerseFavorite(store, action, next);
    } else if (action is GetCurrentVersesAction ||
        action is GetCurrentFavAction ||
        action is GetMoreCurrentVersesAction ||
        action is GetMoreCurrentFavAction) {
      _getCurrentVerses(store, action, next);
    }
  }

  Future<Null> _getCategories(action, NextDispatcher next) async {
    try {
      List<VerseCategory> categories = await categoryLocal.getCategories();
      next(VerseCategorySuccessfulAction(categories));
    } catch (e) {
      next(action);
    }
  }

  Future<Null> _getLatestVerses(NextDispatcher next) async {
    List<Verse> gottenVerses = await verseRepository.getLatestVerses();

    next(LatestVerseSuccessfulAction(gottenVerses));
  }

  Future<Null> _toggleVerseFavorite(
      Store store, action, NextDispatcher next) async {
    if (action is ToggleVerseFavoriteAction) {
      Verse toggledVerse =
          action.verseToToggle.copyWith(isFaved: !action.verseToToggle.isFaved);

      await verseLocal.updateVerse(toggledVerse);
      next(ToggleVerseFavoriteSuccessFulAction(toggledVerse));
    }
  }

  Future<Null> _getCurrentVerses(
      Store store, action, NextDispatcher next) async {
    int perPage = 10;
    int currentPage = verseCountSelector(store.state, action.type);
    int offset = (currentPage - 1) * perPage;

    //if pagenumber is set in action, dont get this one again.
    verseLocal
        .getVersesCount(action.type, categoryId: action.categoryID)
        .then((totalRows) {
      int totalPages = (totalRows / perPage).ceil();
      if (action.type == VerseDisplayType.category) {
        next(SetCurrentVersePagesAction(totalPages));
      } else {
        next(SetCurrentFavoritePagesAction(totalPages));
      }
    });

    verseLocal
        .getVerses(action.type,
            action: action.action,
            limit: perPage,
            offset: offset,
            categoryId: action.categoryID)
        .then((verses) {
      if (action.type == VerseDisplayType.category) {
        next(CurrentVersesSuccessfulAction(verses));
      } else {
        next(CurrentFavSuccessfulAction(verses));
      }
    });
  }
}

/*List<Middleware<AppState>> createVerseMiddleWare(VerseRepository verseRepository, VerseLocal verseLocal, CategoryLocal categoryLocal) {
 

  return [
    new TypedMiddleware<AppState, LatestVerseAction>(
        _getLatestVerses(verseRepository)),
    new TypedMiddleware<AppState, GetVerseCategoryAction>(
        _getCategories(categoryLocal)),
    new TypedMiddleware<AppState, GetCurrentVersesAction>(
        _getCurrentVerses(verseLocal)),
    new TypedMiddleware<AppState, GetCurrentFavAction>(
        _getCurrentVerses(verseLocal)),
    new TypedMiddleware<AppState, GetMoreCurrentVersesAction>(
        _getCurrentVerses(verseLocal)),
    new TypedMiddleware<AppState, GetMoreCurrentFavAction>(
        _getCurrentVerses(verseLocal)),
    new TypedMiddleware<AppState, ToggleVerseFavoriteAction>(
        _toggleVerseFavorite(verseLocal)),
  ];
}

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
  return (Store store, action, NextDispatcher next) async {
    categoryLocal
        .getCategories()
        .then((categories) => next(VerseCategorySuccessfulAction(categories)))
        .catchError((error) => next(action));

    next(action);
  };
}

Middleware<AppState> _getCurrentVerses(VerseLocal verseLocal) {
  return (Store store, action, NextDispatcher next) async {

    next(action);
    
       int perPage = 10;
       int currentPage = verseCountSelector(store.state, action.type);
       int offset = (currentPage - 1) * perPage;

      //if pagenumber is set in action, dont get this one again.
      verseLocal.getVersesCount(action.type,
                    categoryId: action.categoryID).then((totalRows){
                int totalPages = (totalRows / perPage).ceil();
                if (action.type == VerseDisplayType.category) {
                  next(SetCurrentVersePagesAction(totalPages));
                } else {
                  next(SetCurrentFavoritePagesAction(totalPages));
                }
            });

        verseLocal.getVerses(action.type,
          action: action.action,
          limit: perPage,
          offset: offset,
          categoryId: action.categoryID).then((verses){
        if (action.type == VerseDisplayType.category) {
                next(CurrentVersesSuccessfulAction(verses));
              } else {
                next(CurrentFavSuccessfulAction(verses));
              }
          });     
  };
}

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
    //this is actually done if all is well
    next(LatestVerseSuccessfulAction(gottenVerses));
  };
}
*/
