import 'package:flutter/material.dart';
import 'package:flutter_emergency_app_one/redux/fact/fact_state.dart';
import 'package:flutter_emergency_app_one/redux/image/image_state.dart';
import 'package:flutter_emergency_app_one/redux/quote/quote_state.dart';
import 'package:flutter_emergency_app_one/redux/verse/verse_state.dart';

class AppState {
  List<Widget> appbarActions;
  FloatingActionButton floatingActionButton;
  bool isUpdated;
  FactState factState;
  ImageState imageState;
  QuoteState quoteState;
  VerseState verseState;

  AppState({
    this.appbarActions,
    this.floatingActionButton,
    this.isUpdated,
    this.factState,
    this.imageState,
    this.quoteState,
    this.verseState,
  });

  factory AppState.initial() {
    // FIXME: Change all the sub states from null to <substate.initial() when created
    return AppState(
      appbarActions: [],
      floatingActionButton: null,
      isUpdated: false,
      factState: null,
      imageState: null,
      quoteState: null,
      verseState: VerseState.initial(),
    );
  }

  AppState copyWith({
    List<Widget> appbarActions,
    FloatingActionButton floatingActionButton,
    bool isUpdated,
    FactState factState,
    ImageState imageState,
    QuoteState quoteState,
    VerseState verseState,
  }) {
    return AppState(
      appbarActions: appbarActions ?? this.appbarActions,
      floatingActionButton: floatingActionButton ?? this.floatingActionButton,
      isUpdated: isUpdated ?? this.isUpdated,
      factState: factState ?? this.factState,
      imageState: imageState ?? this.imageState,
      quoteState: quoteState ?? this.quoteState,
      verseState: verseState ?? this.verseState,
    );
  }
}
