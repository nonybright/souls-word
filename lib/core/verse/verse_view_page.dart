import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_emergency_app_one/core/verse/verse_view_view_model.dart';
import 'package:flutter_emergency_app_one/models/verse.dart';
import 'package:flutter_emergency_app_one/redux/app/app_state.dart';

enum VerseDisplayType { favorite, category }

class VerseViewPage extends StatefulWidget {
  final int currentIndex;
  final VerseDisplayType viewType;

  VerseViewPage(this.viewType, this.currentIndex, {Key key}) : super(key: key);

  @override
  _VerseViewPageState createState() => new _VerseViewPageState();
}

class _VerseViewPageState extends State<VerseViewPage> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    index = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verse'),
      ),
      body: StoreConnector<AppState, VerseViewViewModel>(
          converter: (store) =>
              VerseViewViewModel.fromStore(store, widget.viewType),
          builder: (_, viewModel) {
            return VerseViewContent(
              viewModel.currentViewed,
              canGoFoward: viewModel.canGoForward,
              canGoBackward: viewModel.canGoBackward,
              onFowardTapped: () {
                viewModel.getCurrentVerse(++index);
              },
              onBackTapped: () {
                viewModel.getCurrentVerse(--index);
              },
            );
          }),
    );
  }
}

class VerseViewContent extends StatelessWidget {
  final Verse currentVerse;
  final Function onFowardTapped;
  final Function onBackTapped;
  final Function canGoFoward;
  final Function canGoBackward;

  VerseViewContent(this.currentVerse,
      {@required this.onFowardTapped,
      @required this.onBackTapped,
      @required this.canGoFoward,
      @required this.canGoBackward});
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        viewBox(currentVerse.content),
        controlBox(),
      ],
    );
  }

  Widget viewBox(verseText) {
    return Center(
      child: Text(verseText),
    );
  }

  Widget controlBox() {
    bool forwardAllowed = canGoFoward();
    bool backwardAllowed = canGoBackward();

    return Center(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: backwardAllowed
                ? () {
                    onBackTapped();
                  }
                : null,
          ),
          Expanded(
            child: Container(),
          ),
          IconButton(
            icon: Icon(Icons.arrow_right),
            onPressed: forwardAllowed
                ? () {
                    onFowardTapped();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
