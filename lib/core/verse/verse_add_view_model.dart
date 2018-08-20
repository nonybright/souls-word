import 'dart:async';

import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/models/verse_category.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_actions.dart';
import 'package:redux/redux.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';

class VerseAddViewModel {
  final Function(VerseCategory) addVerseCategory;
  final Function(Verse) addVerse;

  VerseAddViewModel({
    this.addVerseCategory,
    this.addVerse,
  });

  static VerseAddViewModel fromStore(Store<AppState> store) {
    return VerseAddViewModel(
      addVerseCategory: (VerseCategory categoryToAdd) {
        
            final Completer<Null> completer = new Completer<Null>();
            store.dispatch(AddVerseCategory(categoryToAdd, completer));
            completer.future.then((_){

         });
      },
      addVerse:  (Verse verseToAdd){
          final Completer<Null> completer = new Completer<Null>();
          store.dispatch(AddVerseAction(verseToAdd, completer));
          completer.future.then((_){

         }).catchError((err){
           
         });
      }
    );
  }
}
